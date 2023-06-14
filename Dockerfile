# syntax=docker/dockerfile:1

FROM python:3.8-slim-buster
WORKDIR /app
COPY requirements.txt requirements.txt
RUN pip3 install -r requirements.txt


RUN apt-get update && apt-get install -y wget && rm -rf /var/lib/apt/lists/*

RUN DD_AGENT_MAJOR_VERSION=7 DD_API_KEY=<YOUR_DD_API_KEY> DD_SITE="<YOUR_DD_SITE>" \
    DD_INSTALL_ONLY=true bash -c "$(wget -O- https://raw.githubusercontent.com/DataDog/datadog-agent/master/cmd/agent/install_script.sh)"

COPY . .

CMD ["python3", "-m" , "flask", "run", "--host=0.0.0.0"]