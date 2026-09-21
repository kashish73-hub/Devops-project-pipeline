FROM python:3.11-slim AS builder
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir --user -r requirements.txt

FROM python:3.11-slim AS runner
WORKDIR /app
RUN useradd -m appuser && chown -R appuser:appuser /app
COPY --from=builder /root/.local /home/appuser/.local
COPY --chown=appuser:appuser app.py .
ENV PATH=/home/appuser/.local/bin:$PATH
USER appuser
EXPOSE 5000
CMD ["python", "app.py"]
