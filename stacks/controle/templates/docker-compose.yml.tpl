services:
  postgres:
    image: postgres:16-alpine
    restart: unless-stopped
    environment:
      POSTGRES_DB: mlflow
      POSTGRES_USER: mlflow
      POSTGRES_PASSWORD: ${postgres_password}
    volumes:
      - postgres-data:/var/lib/postgresql/data
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U mlflow"]
      interval: 10s
      timeout: 5s
      retries: 5

  mlflow:
    image: ${mlflow_image_uri}
    restart: unless-stopped
    depends_on:
      postgres:
        condition: service_healthy
    ports:
      - "5000:5000"
    command:
      - "mlflow"
      - "server"
      - "--backend-store-uri"
      - "postgresql://mlflow:${postgres_password}@postgres:5432/mlflow"
      - "--default-artifact-root"
      - "s3://${mlflow_bucket}/artifacts"
      - "--host"
      - "0.0.0.0"
      - "--port"
      - "5000"

volumes:
  postgres-data:
