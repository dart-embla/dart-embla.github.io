pub build
git add build/web
git commit -m "Build $(date -u +"%F %T %Z")"
git subtree push --prefix build/web origin master
