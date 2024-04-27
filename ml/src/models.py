from pydantic import BaseModel
from typing import List


class Message(BaseModel):
    lesson_id: str
    role: int
    text: str
    date: str


class Category(BaseModel):
    name: str
    score: float


class ClassifierOutput(BaseModel):
    lesson_id: str
    role: int
    text: str
    date: str

    categories: List[Category]


class ExplainerOutput(BaseModel):
    summary: str
