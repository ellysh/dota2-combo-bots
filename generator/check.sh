#!/bin/bash -x

set -e

CSV_DIR="database/csv"
DICTIONARY="dictionary.txt"

./validator.py $CSV_DIR/heroes.csv $DICTIONARY 1
./validator.py $CSV_DIR/item_recipe.csv $DICTIONARY 1
./validator.py $CSV_DIR/item_build.csv $DICTIONARY 1
./validator.py $CSV_DIR/item_sell.csv $DICTIONARY 1
./validator.py $CSV_DIR/skill_build.csv $DICTIONARY 1
./validator.py $CSV_DIR/skill_usage.csv $DICTIONARY 1
./validator.py $CSV_DIR/team_desires.csv $DICTIONARY 1
./validator.py $CSV_DIR/player_desires.csv $DICTIONARY 1
./validator.py $CSV_DIR/attack_target.csv $DICTIONARY 1

sort -u -o $DICTIONARY $DICTIONARY
