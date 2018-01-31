#!/bin/bash

set -e

FILES=$(ls *.lua)

for FILE in $FILES
do
  if [ $FILE != "hero_selection_integration_test.lua" ]
  then
    echo "Run $FILE:"
    lua $FILE $1
  fi
done
