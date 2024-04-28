import requests

from fastapi import FastAPI, File, UploadFile, HTTPException
from fastapi.middleware.cors import CORSMiddleware

from src.models import *

from src.classifier import Classifier
from src.explainer import Explainer
from src.constants import *
from src.utils import get_messages_from_database

from typing import List, Dict

import logging
import sys

# Configure logging
logging.basicConfig(level=logging.INFO,
                    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s',
                    handlers=[
                        logging.StreamHandler(sys.stdout)
                    ])


app = FastAPI()

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

logging.info("Models are loading, please wait...")
logging.info("Classifier is loading...")
classifier = Classifier(model_path=CLASSIFIER_MODEL_PATH)
logging.info("Classifier has been loaded!")
logging.info("Explainer is loading...")
explainer = Explainer(repo_id=EXPLAINER_REPO_ID, model_file_name=EXPLAINER_MODEL_NAME)
logging.info("Explainer has been loaded!")


@app.get("/")
def read_root():
    return {"Hello": "World"}


@app.post("/classifyMessages")
def classify_messages(lesson_id: str) -> List[ClassifierOutput]:
    messages = get_messages_from_database(DATABASE_SERVER_URL + "/messages", lesson_id)
    
    classifier_outputs = classifier.predict([message["text"] for message in messages])

    results: List[ClassifierOutput] = []
    for message, categories in zip(messages, classifier_outputs):
        categories = [Category(name=CLASSIFIER_MODEL_LABELS_MAPPING[category["label"]], score=category["score"])
                      for category in categories]
        
        results.append(ClassifierOutput(
            lesson_id=message["lessonID"],
            role=message["role"],
            text=message["text"],
            date=message["date"],
            categories=categories
        ))
    
    return results


@app.post("/explainMessages")
def explain_messages(classified_messages: List[ClassifierOutput]) -> ExplainerOutput:
    messages_to_summarize = []
    for message in classified_messages:
        for category in message.categories:
            if category.score >= EXPLAINER_THRESHOLD:
                messages_to_summarize.append(message.text)
                break

    print("---", messages_to_summarize)
    if not messages_to_summarize:
        return ExplainerOutput(summary="Урок с нейтральным оттенком")

    summary = explainer.predict(messages_to_summarize)
    return ExplainerOutput(summary=summary)


@app.post("/stats")
def get_statistics(classified_messages: List[ClassifierOutput]):
    statistic = {value: 0 for value in CLASSIFIER_MODEL_LABELS_MAPPING.values()}

    for message in classified_messages:
        for category in message.categories:
            if category.score >= CATEGORY_THRESHOLD:
                statistic[category.name] += 1

    statistic["Ничего"] = len(classified_messages) - sum(statistic.values())

    statistic = [Statistic(category=key, value=value) for key, value in statistic.items()]

    marks = {stat.category: stat.value for stat in statistic if stat.category != "Ничего"}
    
    normalized_marks = {}
    total_marks = sum(marks.values())

    for key in marks.keys():
        if total_marks != 0:
            normalized_marks[key] = marks[key] / total_marks

            if key in ["Технические неполадки", "Ругательство", "Сложности в понимании"]:
                normalized_marks[key] = 1 - normalized_marks[key]

            normalized_marks[key] = normalized_marks[key] * 5
        else:
            normalized_marks[key] = 2.5

    normalized_marks = {MARKS_MAPPING[key]: value for key, value in normalized_marks.items()}
    normalized_marks = [Mark(category=key, value=value) for key, value in normalized_marks.items()]

    return {"counts": statistic, "marks": normalized_marks}
    