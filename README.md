# Stellar Core Prometheus exporter Docker image

This is a repo to build a Docker image for [Stellar Core Prometheus expoerter](https://github.com/stellar/packages/tree/master/stellar-core-prometheus-exporter).

It is intended to be used as a sidecar container inside Kubernetes Pod running Stellar Core. Stellar Core image may be pretty heavy depending on what packages you use for Core history upload.

## Why don't we use deb package?

Official `deb` packages has `stellar-core` package as a dependency which we do not need if we run it in Kubernetes in one Pod with Stellar Core.
