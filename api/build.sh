#!/usr/bin/env sh

if [[ -z $EMBLA_DIR ]]; then
  echo "Please set EMBLA_DIR to the Embla source directory"
  exit 1
fi

dartdoc \
  --input=$EMBLA_DIR \
  --output=../web/api \
  --header=header.html \
  --footer=footer.html
