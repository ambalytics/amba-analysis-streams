FROM python:3.8

WORKDIR /code
COPY requirements.txt /code/
RUN pip install -r requirements.txt --no-cache-dir
COPY . /code/
ENV FLASK_APP app.py
CMD flask run --host=0.0.0.0