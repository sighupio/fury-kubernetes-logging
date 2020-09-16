#!/usr/bin/env bash
# Copyright (c) 2020 SIGHUP s.r.l All rights reserved.
# Use of this source code is governed by a BSD-style
# license that can be found in the LICENSE file.


# set -x
set -e
set -u
set -o pipefail

find . -type f \
  -name 'kustomization.yaml' \
  -not -path './examples/*' | \
sort | \
xargs dirname | \
while read -r dir; do
    echo "------------- RUNNING TESTS INTO $dir ---------"
    kustomize build "$dir" > /dev/null
    set +e
    kustomize build "$dir" | pytest -svv --disable-pytest-warnings katalog/tests/test.py
    set -e
done

exit 0
