FROM python:3.7-alpine

RUN apk add --update --no-cache bash coreutils git curl build-base
RUN pip3 install --upgrade awscli

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
