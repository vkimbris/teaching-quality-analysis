FROM python:3.10-slim

WORKDIR /ml

COPY . /ml

RUN pip install torch --index-url https://download.pytorch.org/whl/cpu

RUN pip install --no-cache-dir -r requirements.txt

EXPOSE 8001

CMD ["bash", "run.sh"]