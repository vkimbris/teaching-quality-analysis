import pandas as pd

from fastapi import FastAPI, File, UploadFile, HTTPException
from fastapi.middleware.cors import CORSMiddleware

from pymongo import MongoClient

from src.constants import *
from src.models import *
from src.db_utils import *
from src.parsing import parse_file


app = FastAPI()

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

client = MongoClient(MONGO_URI)

database = create_database(client=client, database_name=MONGO_DATABASE_NAME)

messages_collection = create_collection(database=database, collection_name=MONGO_MESSAGES_COLLECTION_NAME)
lessons_collection = create_collection(database=database, collection_name=MONGO_LESSONS_COLLECTION_NAME)


@app.get("/")
def read_root():
    return {"Hello": "World"}

    
@app.post("/uploadFile")
async def upload_lessons_and_messages(file: UploadFile = File(...)):
    contents = await file.read()
    
    lessons, messages = parse_file(pd.read_excel(contents))

    try:
        lessons_collection.insert_many([lesson.dict() for lesson in lessons])
        messages_collection.insert_many([message.dict() for message in messages])

        return {"status": "OK"}

    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))
    
@app.get("/lessons")
def get_lessons():
    lessons = []

    for lesson in lessons_collection.find():
        lessons.append({
            "id": lesson["id"],
            "startDate": lesson["start_date"]
        })

    return lessons


@app.get("/messages")
def get_messages(lesson_id: str):
    messages = []

    for message in messages_collection.find({"lesson_id": lesson_id}):
        messages.append({
            "lessonID": lesson_id,
            "role": 0 if message["role"] == "user" else 1,
            "text": message["text"],
            "date": message["date"]
        })

    return messages
