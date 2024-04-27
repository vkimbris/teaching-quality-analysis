from pymongo import MongoClient

from pymongo.database import Database
from pymongo.collection import Collection


def create_database(client: MongoClient, database_name: str) -> Database:
    db = client[database_name]

    return db


def create_collection(database: Database, collection_name: str) -> Collection:
    collection = database[collection_name]

    return collection