#!/bin/bash

set -euo pipefail

echo "Npm install"

npm install

echo -e "\033[0;32mDeploying updates to GitHub...\033[0m"
echo -e "\033[0;32mRunning hugo...\033[0m"

hugo --minify --printPathWarnings --gc


echo -e "\033[0;32m Uploading  pubilc folder...\033[0m"

# Go To Public folder
cd public
# Add changes to git.
git add -A

# Commit changes.
msg="rebuilding site `date`"
if [ $# -eq 1 ]
  then msg="$1"
fi
git commit -m "$msg"

# Push source and build repos.
git push origin master

# Come Back
cd ..