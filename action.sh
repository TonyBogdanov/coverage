#!/usr/bin/env bash

set -e

if [[ -z "${1}" ]]
then
    echo "Path to the coverage folder is required and must be specified."
    exit 1
fi

if [[ ! -d "${1}" ]]
then
    echo "Path to the coverage folder is invalid: \"${1}\"."
    exit 1
fi

if [[ ! -f "${1}/coverage.xml" ]]
then
    echo "Coverage folder is invalid, missing clover file: \"${1}/coverage.xml\"."
    exit 1
fi

if [[ ! -d "${1}/_css" ]]
then
    echo "Coverage folder is invalid, missing sub-folder: \"${1}/_css\"."
    exit 1
fi

if [[ ! -d "${1}/_js" ]]
then
    echo "Coverage folder is invalid, missing sub-folder: \"${1}/_js\"."
    exit 1
fi

if [[ ! -d "${1}/_icons" ]]
then
    echo "Coverage folder is invalid, missing sub-folder: \"${1}/_icons\"."
    exit 1
fi

php /coverage/fix.php
/coverage/vendor/bin/php-coverage-badger "${1}/coverage.xml" "${1}/coverage.svg"

if [[ ! -z "${2}" ]]
then
    shopt -s globstar

    for i in **/*.html; do
        echo "Encrypting ${i}..."
        node /coverage/node_modules/better-staticrypt -e -o "$i" "$i" "${2}"
    done
fi
