FROM python:3.9-slim
WORKDIR /app
RUN pip install fastapi uvicorn sqlalchemy psycopg2-binary httpx
COPY . .
EXPOSE 8082
CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8082"]