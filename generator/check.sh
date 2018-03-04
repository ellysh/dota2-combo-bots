#!/bin/bash -x

set -e

CSV_DIR="database/csv"
DICTIONARY="dictionary.txt"
FIRST_RUN=0

./validator.py $CSV_DIR/heroes.csv $DICTIONARY $FIRST_RUN
./validator.py $CSV_DIR/item_sets.csv $DICTIONARY $FIRST_RUN
./validator.py $CSV_DIR/item_builds.csv $DICTIONARY $FIRST_RUN
./validator.py $CSV_DIR/item_sell.csv $DICTIONARY $FIRST_RUN
./validator.py $CSV_DIR/skill_builds.csv $DICTIONARY $FIRST_RUN
./validator.py $CSV_DIR/skill_usage.csv $DICTIONARY $FIRST_RUN
./validator.py $CSV_DIR/skill_groups.csv $DICTIONARY $FIRST_RUN
./validator.py $CSV_DIR/team_desires.csv $DICTIONARY $FIRST_RUN
./validator.py $CSV_DIR/player_desires.csv $DICTIONARY $FIRST_RUN
./validator.py $CSV_DIR/attack_target.csv $DICTIONARY $FIRST_RUN

sort -u -o $DICTIONARY $DICTIONARY
