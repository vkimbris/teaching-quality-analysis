from typing import List, Dict

from transformers import AutoModelForSequenceClassification, AutoTokenizer
from transformers import pipeline


class Classifier:

    def __init__(self, model_path: str) -> None:
        model = AutoModelForSequenceClassification.from_pretrained(model_path)
        tokenizer = AutoTokenizer.from_pretrained(model_path)

        self.classifier = pipeline(task="text-classification", model=model, tokenizer=tokenizer, top_k=4)

    def predict(self, texts: List[str]) -> List[List[Dict[str, float]]]:
        return self.classifier(texts)
