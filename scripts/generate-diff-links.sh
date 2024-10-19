#!/usr/bin/env bash

set -o errexit
set -o nounset

GIT_HASH="${1:-50aeb31ff80e7bdde9b8edd50ab924e3791fe606}"

BASE_LOCAL_URL="http://127.0.0.1:8000/bash-hackers-wiki/"
BASE_DEPLOY_URL="https://flokoe.github.io/bash-hackers-wiki/"
BASE_ARCHIVE_URL="https://web.archive.org/web/20230127020427/https://wiki.bash-hackers.org/"

# Table Headers
cat << EOF
|Filename|Local Version|Deployed Version|Archive Version|
|--|--|--|--|
EOF

for file in $(git show --name-only "${GIT_HASH}" | grep md$); do
  filename_no_docs_prefix="${file#*docs/}"
  filename_no_ext="${filename_no_docs_prefix%.*}"
  echo "|"${filename_no_docs_prefix} \
    "|[${filename_no_ext}](${BASE_LOCAL_URL}${filename_no_ext})" \
    "|[${filename_no_ext}](${BASE_DEPLOY_URL}${filename_no_ext})" \
    "|[${filename_no_ext}](${BASE_ARCHIVE_URL}${filename_no_ext})|"
done

