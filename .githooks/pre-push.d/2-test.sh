#!/usr/bin/env bash

if git log --format=%B -n 1 | grep -q "\[skip ci\]\|\[ci skip\]"; then
    printf "\e[33;1m%s\e[0m\n" "Skipping $0"
    exit 0
fi

set -e

printf "\e[33;1m%s\e[0m\n" 'Running the tests'
bundle exec rake test
if [[ $? -ne 0 ]]; then
    printf "\e[31;1m%s\e[0m\n" 'tests error'
    exit 1
fi
printf "\e[33;1m%s\e[0m\n" 'Finished running the tests'