
FROM python:3.11-slim
LABEL org.opencontainers.image.source https://github.com/fruizotero/back-calculadora-template

WORKDIR /app

COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

COPY . .

EXPOSE 8000

CMD ["fastapi", "dev", "main.py", "--host", "0.0.0.0", "--port", "8000"]