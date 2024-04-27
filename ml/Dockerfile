FROM python:3.10-slim

WORKDIR /ml

COPY . /ml

RUN pip install --no-cache-dir -r requirements.txt

EXPOSE 8001

CMD ["bash", "run.sh"]