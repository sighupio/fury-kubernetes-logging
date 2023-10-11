# Copyright (c) 2021 SIGHUP s.r.l All rights reserved.
# Use of this source code is governed by a BSD-style
# license that can be found in the LICENSE file.

# hadolint ignore=DL3007
FROM quay.io/sighup/policeman:latest as linter

ENV VALIDATE_KUBERNETES_KUBEVAL="false"
ENV VALIDATE_JSCPD="false"
ENV VALIDATE_DOCKERFILE="false"

RUN mkdir /app
WORKDIR /app

COPY . .

RUN npm install -g embedme@1.22.0 && /entrypoint.sh && embedme --verify "**/*.md"

FROM golang:1.16 as add-license-requirement

RUN go get -u github.com/google/addlicense && addlicense -c "SIGHUP s.r.l" -v -l bsd .

FROM golang:1.16 as check-license

RUN go get -u github.com/google/addlicense && mkdir /app

WORKDIR /app

COPY . .

RUN addlicense -c "SIGHUP s.r.l" -v -l bsd --check .


