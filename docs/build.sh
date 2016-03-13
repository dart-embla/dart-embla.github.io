#!/usr/bin/env bash

set -e

git submodule foreach git pull origin master

# Build docs to build/web/docs
mkdir build/web/docs
echo "Docs coming soon!" > build/web/docs/index.html
