FROM python:3.7-alpine

RUN apk add --update --no-cache bash git curl
RUN pip3 install --upgrade awscli

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]