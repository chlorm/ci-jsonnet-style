#!/usr/bin/env bash

set -o errexit
set -o pipefail

mapfile -t jsonnetFiles < <(
    find "$GITHUB_WORKSPACE" \
        -name 'vendor' -prune \
        -o -name '*.libsonnet' -print \
        -o -name '*.jsonnet' -print
)

for i in "${jsonnetFiles[@]}"; do
    jsonnetfmt --in-place "$i"
done

DIFF_RESULT="$(git diff)"
if [ -n "$DIFF_RESULT" ]; then
    echo "$DIFF_RESULT"
    return 1
fi
