#!/usr/bin/env bash

set -e

php /coverage/fix.php
/coverage/vendor/bin/php-coverage-badger "${1}/coverage.xml" "${1}/coverage.svg"

shopt -s globstar

for i in **/*.html; do
    echo "Encrypting ${i}..."
    node /coverage/node_modules/better-staticrypt -e -o "$i" "$i" "${2}"
done
