FROM python:3.10-slim

WORKDIR /ml

COPY . /ml

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    g++ \
    cmake \
    && rm -rf /var/lib/apt/lists/*

RUN pip install torch --index-url https://download.pytorch.org/whl/cpu

RUN pip install --no-cache-dir -r requirements.txt

EXPOSE 8001

CMD ["bash", "run.sh"]