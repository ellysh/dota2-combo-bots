#!/bin/bash -x

FILES=$(ls *.lua)

lua hero_selection_test.lua

lua item_purchase_test.lua

lua functions_test.lua

lua courier_test.lua

exit 0

for FILE in $FILES
do
    lua $FILE && echo "$FILE: Succeed" || echo "$FILE: Failed"
done
