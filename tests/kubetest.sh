#!/usr/bin/env bash

# set -x
set -e
set -u
set -o pipefail

echo $PATH

find . -type d \
  -maxdepth 1 \
  -mindepth 1 \
  -not -path "./.git" \
  -not -path "./examples" \
  -not -path "./tests" | \
while read dir; do
    echo "------------- RUNNING TESTS INTO $dir ---------"
    kustomize build "$dir" > /dev/null
    set +e
    kustomize build "$dir" | grep -v 'creationTimestamp: null' | kubetest --tests tests/
    set -e
done

exit 0
