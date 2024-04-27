import requests

from typing import List, Dict


def get_messages_from_database(url: str, lesson_id: str) -> List[Dict]:    
    response = requests.get(url, params={"lesson_id": lesson_id})

    return response.json()