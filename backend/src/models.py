from pydantic import BaseModel


class LessonInput(BaseModel):
    id: str
    start_date: str


class MessageInput(BaseModel):
    lesson_id: str
    role: str
    text: str
    date: str