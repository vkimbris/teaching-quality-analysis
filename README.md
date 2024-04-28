# Решение команды "Своего рода ученые" для хакатона "Анализ качества преподавания" от Цифрового прорыва

## Варианты взаимодействия с решением
1. Удаленно. Наше решение развернуто на YandexCloud
   Ссылка на UI:
2. Локально. Инструкция по установке ниже

Обратите внимание, что на YandexCloud в базу данных уже загружены данные по урокам из файла, предоставленным организаторами.
В случае локальной установки вам необходимо загрузить данные в базу. Данные должны быть в формате Excel (пример файла находится в репозитории)

## Установка

1. Убедитесь, что у вас установлен `docker`. Для Linux: `sudo apt-get install docker.io`
2. Выполните команду `docker-compose up --build`
3. Откройте в браузере http://localhost:8003

## Описание методов
### Взаимодействие с MongoDB.
Swagger: http://158.160.114.28:8000/docs

#### POST /uploadFile
Метод для загрузки файлов в базу данных. Файл должен быть в формате Excel. Пример файла находится в репозитории. В случае успеха возвращает:
```json
{"status": "OK"}
```

#### GET /lessons
Возвращает список уроков в следующем формате:
```json
[
  {
    "id": "307751",
    "startDate": "03-06-2024 10:02:38"
  },
  {
    "id": "307752",
    "startDate": "03-13-2024 09:51:49"
  },
]
```

#### GET /messages
Принимает на вход единственный query parameter **lesson_id**. Возвращает сообщения в следующем формате:
```json
[
  {
    "lessonID": "321814",
    "role": 0,
    "text": "Здравия желаю",
    "date": "2024-03-09 12:59:48"
  },
  {
    "lessonID": "321814",
    "role": 0,
    "text": "Отставить",
    "date": "2024-03-09 13:00:36"
  },
]
```

### Взаимодействие с ML Backend
Swagger: http://158.160.114.28:8002/docs

#### POST /classifyMessages
Метод классифицирует каждое сообщение в несколько классов. Каждое сообщение может одновременно принадлежать к более, чем одному классу. Принимает на вход единственный query parameter **lesson_id**. Возвращает список объектов в формате:
```json
[
  {
    "lesson_id": "321814",
    "role": 0,
    "text": "здравствуйте у меня получилось зайти",
    "date": "2024-03-09 13:46:24",
    "categories": [
      {
        "name": "Все отлично",
        "score": 0.9190982580184937
      },
      {
        "name": "Сложности в понимании",
        "score": 0.03561590239405632
      },
      {
        "name": "Ругательство",
        "score": 0.031024159863591194
      },
      {
        "name": "Технические неполадки",
        "score": 0.0236750990152359
      }
    ]
  }
]
```
#### POST /explainMessages
Метод осуществляет суммаризацию сообщений учеников в чате по возможным проблемам, возникшим в ходе занятия. Принимает на вход ответ метода **/classifyMessages**. Возвращает ответ вида:
```json
{
  "summary": "Пользователи столкнулись со следующими проблемами: непонятные сообщения, отсутствие информации о том, что желают не заходить в доту, проблемы с микрофоном и стим стримингом.     Положительные впечатления: ладжность, желание не заходить в доту, положительные впечатления от написанного."
}
```

#### POST /stats
Метод возвращает статистику количества сообщений разных классов в чате. Принимает на вход ответ метода **/classifyMessages**. Возвращает ответ вида:
```json
[
  {
    "category": "Технические неполадки",
    "value": 0
  },
  {
    "category": "Ругательство",
    "value": 0
  },
  {
    "category": "Сложности в понимании",
    "value": 0
  },
  {
    "category": "Все отлично",
    "value": 5
  },
  {
    "category": "Ничего",
    "value": 52
  }
]
```
