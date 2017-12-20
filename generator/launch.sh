#!/bin/bash

CSV_DIR="database/csv"
RESULT_DIR="../bot/database"

./generator.py HEROES 9 $CSV_DIR/heroes.csv > $RESULT_DIR/heroes.lua
./generator.py ITEM_RECIPE 5 $CSV_DIR/item_recipe.csv > $RESULT_DIR/item_recipe.lua
./generator.py ITEM_BUILD 10 $CSV_DIR/item_build.csv > $RESULT_DIR/item_build.lua
