#!/bin/bash

CSV_DIR="database/csv"
RESULT_DIR="../bot/database"

./generator.py HEROES 9 $CSV_DIR/heroes.csv > $RESULT_DIR/heroes.lua

./generator.py ITEM_RECIPE 5 $CSV_DIR/item_recipe.csv > $RESULT_DIR/item_recipe.lua

./generator.py ITEM_BUILD 11 $CSV_DIR/item_build.csv > $RESULT_DIR/item_build.lua

./generator.py ITEM_SELL 3 $CSV_DIR/item_sell.csv > $RESULT_DIR/item_sell.lua

./generator.py SKILL_BUILD 20 $CSV_DIR/skill_build.csv > $RESULT_DIR/skill_build.lua

./generator.py SKILL_USAGE 25 $CSV_DIR/skill_usage.csv > $RESULT_DIR/skill_usage.lua
