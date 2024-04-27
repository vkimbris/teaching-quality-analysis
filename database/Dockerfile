FROM python:3.10-slim

WORKDIR /database

COPY . /database

RUN pip install --no-cache-dir -r requirements.txt

EXPOSE 8000

CMD ["bash", "run.sh"]