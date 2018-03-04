#!/bin/bash -x

set -e

CSV_DIR="database/csv"
RESULT_DIR="../bots/database"

./ods2csv.sh

./generator.py HEROES 17 $CSV_DIR/heroes.csv > $RESULT_DIR/heroes.lua

./generator.py ITEM_SETS 5 $CSV_DIR/item_sets.csv > $RESULT_DIR/item_sets.lua

./generator.py ITEM_BUILDS 10 $CSV_DIR/item_builds.csv > $RESULT_DIR/item_builds.lua

./generator.py ITEM_SELL 3 $CSV_DIR/item_sell.csv > $RESULT_DIR/item_sell.lua

./generator.py SKILL_BUILDS 20 $CSV_DIR/skill_builds.csv > $RESULT_DIR/skill_builds.lua

./generator.py SKILL_USAGE 5 $CSV_DIR/skill_usage.csv > $RESULT_DIR/skill_usage.lua

./generator.py SKILL_GROUPS 27 $CSV_DIR/skill_groups.csv > $RESULT_DIR/skill_groups.lua

./generator.py TEAM_DESIRES 17 $CSV_DIR/team_desires.csv > $RESULT_DIR/team_desires.lua

./generator.py PLAYER_DESIRES 27 $CSV_DIR/player_desires.csv > $RESULT_DIR/player_desires.lua

./generator.py ATTACK_TARGET 12 $CSV_DIR/attack_target.csv > $RESULT_DIR/attack_target.lua

./check.sh
