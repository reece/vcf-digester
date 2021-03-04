FROM ubuntu:20.04

RUN apt-get update \
	&& apt-get upgrade -y \

RUN apt install -y \
	python3

RUN pip install -r requirements.txt


