#!/usr/bin/env bash
# Copyright (c) 2023 SIGHUP s.r.l All rights reserved.
# Use of this source code is governed by a BSD-style
# license that can be found in the LICENSE file.
set -euo pipefail

retention_json_file=$1
opensearch_url=$2

echo "Starting tasks"
if [ -z "$retention_json_file" ]; then
  echo "Retention JSON file is not set, usage $0 <retention_json_file> <opensearch_url>"
  exit 1
fi
if [ ! -f "$retention_json_file" ]; then
  echo "File $retention_json_file does not exist, usage $0 <retention_json_file> <opensearch_url>"
  exit 1
fi

if [ -z "$opensearch_url" ]; then
  echo "OpenSearch URL is not set, usage $0 <retention_json_file> <opensearch_url>"
  exit 1
fi

function install_curl_jq() {
  # download the jq binary
  curl -L -o /usr/share/opensearch/bin/jq https://github.com/stedolan/jq/releases/download/jq-1.6/jq-linux64

  # make the binary executable
  chmod +x /usr/share/opensearch/bin/jq
}

function retention_policy_does_not_exist() {
  local policy_name=$1
  local opensearch_url=$2

  # shellcheck disable=SC2155
  local response=$(curl -s -XGET "$opensearch_url/_plugins/_ism/policies/$policy_name")

  if echo "$response" | jq -e '.error.type == "index_not_found_exception"' >/dev/null; then
    return 0
  fi

  if echo "$response" | jq -e '.error.root_cause[0].reason == "Policy not found"' >/dev/null; then
    return 0
  fi

  return 1
}

function put_retention_policy() {
  local index_name=$1
  local retention_json_file=$2
  local opensearch_url=$3

  echo "configuring retention for index $index_name"
  cp "${retention_json_file}" "${index_name}"-retention.json &&
    sed -i "s/INDEXNAME/${index_name}/g" "${index_name}"-retention.json &&
    sed -i "s/SNAPSHOT_MIN_AGE/${SNAPSHOT_MIN_AGE}/g" "${index_name}"-retention.json &&
    sed -i "s/DELETE_MIN_AGE/${DELETE_MIN_AGE}/g" "${index_name}"-retention.json &&
    curl -X PUT "${opensearch_url}/_plugins/_ism/policies/${name}" -H "Content-Type: application/json" -d @./"${name}"-retention.json
}

INDEX_NAME="kubernetes,audit,events,systemd,ingress-controller,infra"

install_curl_jq
IFS=',' read -r -a index_names <<<"$INDEX_NAME"
for name in "${index_names[@]}"; do
  if retention_policy_does_not_exist "${name}" "${opensearch_url}"; then
    put_retention_policy "${name}" "${retention_json_file}" "${opensearch_url}"
  else
    echo "retention policy for index $name already exists"
  fi
done
