#!/usr/bin/env bash

set -e

td=`dirname \`realpath "${0}"\``

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

cd "${1}"

echo "Fixing coverage paths"
php $td/fix.php

echo "Generating coverage badge"
$td/vendor/bin/php-coverage-badger coverage.xml coverage.svg

if [[ -z "${2}" ]]
then
    echo "Encrypting coverage files"
    node $td/encrypt.js "${2}"
fi