#!/bin/bash

set -euo pipefail

echo -e "\033[0;32mNpm install...\033[0m"
npm install


echo -e "\033[0;32mRunning hugo...\033[0m"

hugo --minify --printPathWarnings --gc

