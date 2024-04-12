#!/bin/bash

set -euo pipefail

bash --version

for a in "${@}"; do
  arg=$(echo "$a" | tr '\n' ' ' | xargs echo | sed "s/'//g"| sed "s/’//g")
  sanitizedArgs+=("$arg")
done

echo "${sanitizedArgs[@]}"

exit $?
