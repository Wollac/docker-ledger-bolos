# docker-ledger-bolos

[![GitHub License](https://img.shields.io/github/license/wollac/docker-ledger-bolos?color=blue)](https://github.com/Wollac/docker-ledger-bolos/blob/master/LICENSE)
[![Docker Build Status](https://img.shields.io/docker/cloud/build/wollac/ledger-bolos)](https://hub.docker.com/r/wollac/ledger-bolos)

A simple Ubuntu based Docker image that contains the toolchain for building Ledger Nano S and Ledger Blue apps.

## Usage

To build a ledger application, run the following command in the folder where the `Makefile` is located.
The environment variable `BOLOS_SDK` must point the the folder of the corresponding Ledger SDK.
```bash
docker run --rm -t \
-u "$(id -u):$(id -g)" \
-v "$(pwd):/project" \
-v "$BOLOS_SDK:/opt/sdk" -e BOLOS_SDK="/opt/sdk" \
wollac/ledger-bolos make -C /project'
```
