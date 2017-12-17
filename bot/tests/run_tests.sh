#!/bin/bash

FILES=$(ls *.lua)

#lua hero_selection_test.lua

for FILE in $FILES
do
    lua $FILE && echo "$FILE: Succeed" || echo "$FILE: Failed"
done
