import pandas as pd

from .models import *

from typing import Tuple, List


def parse_file(df: pd.DataFrame) -> Tuple[List[LessonInput], List[MessageInput]]:
    df = df.fillna("0")
    
    lessons, messages = [], []

    for lesson_id in df["ID урока"].dropna().unique():    
        lesson_df = df[df["ID урока"] == lesson_id]
        lesson_start_date = lesson_df["Дата старта урока"].iloc[0].strftime("%m-%d-%Y %H:%M:%S")

        lesson_id = str(int(lesson_id))

        lessons.append(LessonInput(
            id=lesson_id, start_date=lesson_start_date
        ))
        
        for _, row in lesson_df.iterrows():
            messages.append(MessageInput(
                lesson_id=lesson_id, role=row["Роль пользователя"], text=row["Текст сообщения"], date=row["Дата сообщения"]
            ))

    return lessons, messages