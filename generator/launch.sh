#!/bin/bash -x

set -e

CSV_DIR="database/csv"
RESULT_DIR="../bots/database"

./ods2csv.sh

./generator.py HEROES 9 $CSV_DIR/heroes.csv > $RESULT_DIR/heroes.lua

./generator.py ITEM_RECIPE 5 $CSV_DIR/item_recipe.csv > $RESULT_DIR/item_recipe.lua

./generator.py ITEM_BUILD 14 $CSV_DIR/item_build.csv > $RESULT_DIR/item_build.lua

./generator.py ITEM_SELL 3 $CSV_DIR/item_sell.csv > $RESULT_DIR/item_sell.lua

./generator.py SKILL_BUILD 20 $CSV_DIR/skill_build.csv > $RESULT_DIR/skill_build.lua

./generator.py SKILL_USAGE 25 $CSV_DIR/skill_usage.csv > $RESULT_DIR/skill_usage.lua

./generator.py TEAM_DESIRES 9 $CSV_DIR/team_desires.csv > $RESULT_DIR/team_desires.lua

./generator.py PLAYER_DESIRES 11 $CSV_DIR/player_desires.csv > $RESULT_DIR/player_desires.lua

./generator.py ATTACK_TARGET 11 $CSV_DIR/attack_target.csv > $RESULT_DIR/attack_target.lua

./check.sh
