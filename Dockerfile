FROM ubuntu:20.04

RUN apt-get update \
	&& apt-get upgrade -y

RUN apt install -y \
	python3 \
	python3-pip

COPY requirements.txt /
RUN pip3 install -r requirements.txt

COPY vcf-digester /

ENTRYPOINT ["python3", "vcf-digester"]