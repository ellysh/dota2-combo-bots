#!/bin/bash

FILES=$(ls *.lua)

#lua item_purchase_juggernaut_test.lua

for FILE in $FILES
do
    lua $FILE && echo "$FILE: Succeed" || echo "$FILE: Failed"
done
