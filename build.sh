#!/bin/bash

set -euo pipefail

echo "Npm install"
npm install

echo "Running hugo"
hugo --minify --printPathWarnings --gc


echo -e "\033[0;32mDeploying updates to GitHub...\033[0m"

git submodule add git@github.com:whatstack-tech/whatstack.github.io.git public

echo -e "\033[0;32mAdd public folder to submodule...\033[0m"

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