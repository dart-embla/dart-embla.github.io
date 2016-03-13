#!/usr/bin/env bash

set -e

# Build site
pub build
sh docs/build.sh
sh api/build.sh

# Commit and push subtree
git add build/web
git commit -m "Build $(date -u +"%F %T %Z")"
git subtree push --prefix build/web origin master
