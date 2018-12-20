#!/usr/bin/env bash

# set -x
set -e
set -u
set -o pipefail

find . -type d \
  -maxdepth 1 \
  -mindepth 1 \
  -not -path "./.git" \
  -not -path "./.pytest_cache" \
  -not -path "./examples" \
  -not -path "./tests" | \
while read dir; do
    echo "------------- RUNNING TESTS INTO $dir ---------"
    kustomize build "$dir" > /dev/null
    TMPFILE="$(mktemp)"
    kustomize build "$dir" > "$TMPFILE"
    copper check --rules tests/rules.cop --file "$TMPFILE"
    rm "$TMPFILE"
done

exit 0
