#!/bin/bash

FILES=$(ls *.lua)

for FILE in $FILES
do
  echo "Run $FILE:"
  lua $FILE
done
