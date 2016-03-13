#!/usr/bin/env bash

set -e

git submodule foreach git pull origin master

# Create dir if doesn't exist
if [[ ! -d build/web/docs ]]; then
  mkdir build/web/docs
fi


# For each directory in the docs directory
for VERSION_DIR in $(find docs/source -type d -maxdepth 1); do
  if [[ $VERSION_DIR == "docs/source" ]]; then
    continue
  fi

  LAST_VERSION=$(echo $VERSION_DIR | perl -nle 'm/(\d+.\d+)/; print $1')

  # Run the generate.dart script with the
  dart docs/generate.dart $(find $VERSION_DIR -type f)
done

echo "<html><head><meta http-equiv=\"refresh\" content=\"0; URL='/docs/$LAST_VERSION/'\" /></head></html>" \
  > build/web/docs/index.html
