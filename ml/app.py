import requests

from fastapi import FastAPI, File, UploadFile, HTTPException
from fastapi.middleware.cors import CORSMiddleware

from src.models import Message, ClassifierOutput, Category, ExplainerOutput

from src.classifier import Classifier
from src.explainer import Explainer
from src.constants import *
from src.utils import get_messages_from_database

from typing import List, Dict


app = FastAPI()

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)


classifier = Classifier(model_path=CLASSIFIER_MODEL_PATH)
explainer = Explainer(repo_id=EXPLAINER_REPO_ID, model_file_name=EXPLAINER_MODEL_NAME)


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

    print(messages_to_summarize)

    if not messages_to_summarize:
        return ExplainerOutput(summary="Урок с нейтральным оттенком")

    summary = explainer.predict(messages_to_summarize)
    return ExplainerOutput(summary=summary)
