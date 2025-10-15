FROM python:3.11-slim
WORKDIR /app
COPY /app/canary_receiver.py /app/app.py
RUN pip install --no-cache-dir flask gunicorn
ENV CANARY_BIND=0.0.0.0 CANARY_PORT=5000 CANARY_LOG_DIR=/logs
VOLUME ["/logs"]
CMD ["gunicorn","-w","2","-b","0.0.0.0:5000","app:app"]
