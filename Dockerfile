FROM python:3.7-alpine

ENV HELM_VERSION=${HELM_VERSION:-2.16.1}
RUN apk add --update --no-cache bash \
    && apk add --update --no-cache --virtual .build-deps curl openssl \
    && curl -o helm-v${HELM_VERSION}-linux-amd64.tar.gz https://get.helm.sh/helm-v${HELM_VERSION}-linux-amd64.tar.gz \
    && tar xzvf helm-v${HELM_VERSION}-linux-amd64.tar.gz \
    && mv linux-amd64/helm /usr/local/bin/ \
    && chmod -v +x /usr/local/bin/helm \
    && rm -Rf helm-v${HELM_VERSION}-linux-amd64.tar.gz linux-amd64/ \
    && apk del .build-deps

RUN pip3 install --upgrade --user awscli

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]