FROM python:3.6-slim
ARG SRC=/src

COPY . $SRC/
WORKDIR $SRC

RUN pip install pipenv && pipenv install --dev
