FROM alpine:3.8 as downloader

RUN apk add curl
RUN curl -q -o /usr/local/bin/stellar-core-prometheus-exporter.py https://raw.githubusercontent.com/stellar/packages/b34f5a731a0dc9070ad83e5f8a7b324ba53e9d4f/stellar-core-prometheus-exporter/stellar-core-prometheus-exporter.py \
  && echo 'a80c4290fbadab4557533c8d43df6258c9e378d188c6c11bd34d4304839f72f2  /usr/local/bin/stellar-core-prometheus-exporter.py' | sha256sum -c - \
  && chmod a+x /usr/local/bin/stellar-core-prometheus-exporter.py


FROM alpine:3.8

ARG VCS_REF
ARG BUILD_DATE

LABEL maintainer="Mobius Operations Team <ops@mobius.network>"
LABEL org.label-schema.build-date="${BUILD_DATE}"
LABEL org.label-schema.vcs-ref="${VCS_REF}"
LABEL org.label-schema.vcs-url="https://github.com/mobius-network/docker-stellar-core-prometheus-exporter/"
LABEL org.label-schema.name="stellar-core-prometheus-exporter"

RUN apk add --no-cache python3 && \
  python3 -m ensurepip && \
  rm -r /usr/lib/python*/ensurepip && \
  pip3 install --upgrade pip setuptools && \
  if [ ! -e /usr/bin/pip ]; then ln -s pip3 /usr/bin/pip ; fi && \
  if [[ ! -e /usr/bin/python ]]; then ln -sf /usr/bin/python3 /usr/bin/python; fi && \
  rm -r /root/.cache

RUN pip3 install prometheus-client requests

COPY --from=downloader /usr/local/bin/stellar-core-prometheus-exporter.py /usr/local/bin/stellar-core-prometheus-exporter.py

USER nobody

ENTRYPOINT [ "/usr/local/bin/stellar-core-prometheus-exporter.py" ]
