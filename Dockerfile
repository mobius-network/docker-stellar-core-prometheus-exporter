FROM python:3.7-alpine3.8

ARG VCS_REF
ARG BUILD_DATE

LABEL maintainer="Mobius Operations Team <ops@mobius.network>"
LABEL org.label-schema.build-date="${BUILD_DATE}"
LABEL org.label-schema.vcs-ref="${VCS_REF}"
LABEL org.label-schema.vcs-url="https://github.com/mobius-network/docker-stellar-core-prometheus-exporter/"
LABEL org.label-schema.name="stellar-core-prometheus-exporter"

RUN pip install prometheus-client requests

COPY ./stellar-core-prometheus-exporter.py /usr/local/bin/stellar-core-prometheus-exporter.py

USER nobody

CMD [ "python", "/usr/local/bin/stellar-core-prometheus-exporter.py" ]
