from fastapi import FastAPI, File, UploadFile, HTTPException
from fastapi.middleware.cors import CORSMiddleware

from src.models import Message, ClassifierOutput, Category

from src.classifier import Classifier
from src.constants import *

from typing import List

app = FastAPI()

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)


classifier = Classifier(model_path=CLASSIFIER_PATH)


@app.get("/")
def read_root():
    return {"Hello": "World"}


@app.post("/classifyMessages")
def classify_messages(messages: List[Message]) -> List[ClassifierOutput]:
    classifier_outputs = classifier.predict([message.text for message in messages])

    results: List[ClassifierOutput] = []
    for message, categories in zip(messages, classifier_outputs):
        categories = [Category(name=category["name"], score=category["score"]) for category in categories]
        
        print(message.lesson_id, message.role, message.text)

        results.append(ClassifierOutput(
            lesson_id=message.lesson_id,
            role=message.role,
            text=message.text,
            date=message.date,
            categories=categories
        ))
    
    return results

@app.post("/explainMessages")
def explain_messages():
    pass