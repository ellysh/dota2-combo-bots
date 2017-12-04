#!/bin/bash

FILES=$(ls *.lua)

for FILE in $FILES
do
    lua $FILE && echo "$FILE: Succeed" || echo "$FILE: Failed"
done
