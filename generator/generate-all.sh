#!/bin/bash

CSV_DIR="database/csv"
RESULT_DIR="../bot/database"

./heroes.py $CSV_DIR/heroes.csv > $RESULT_DIR/heroes.lua
./item_recipe.py $CSV_DIR/item_recipe.csv > $RESULT_DIR/item_recipe.lua
