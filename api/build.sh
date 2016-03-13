#!/usr/bin/env bash

set -e

# Build api to build/web/api

if [[ -z $EMBLA_DIR ]]; then
  echo "Set EMBLA_DIR to the main Embla repo source directory."
  exit 1
fi

dartdoc \
  --input=$EMBLA_DIR \
  --output=build/web/api \
  --header=api/header.html \
  --footer=api/footer.html
