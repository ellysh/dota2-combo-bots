#!/bin/bash -x

DATABASE_DIR="database/docs"
TEMP_DIR="database/temp"
CSV_DIR="database/csv"

ssconvert -S -O 'separator=;' "$DATABASE_DIR/Database.ods" "$TEMP_DIR/Database.txt"

cp "$TEMP_DIR/Database.txt.0" "$CSV_DIR/heroes.csv"
cp "$TEMP_DIR/Database.txt.1" "$CSV_DIR/item_sell.csv"
cp "$TEMP_DIR/Database.txt.2" "$CSV_DIR/item_sets.csv"
cp "$TEMP_DIR/Database.txt.3" "$CSV_DIR/item_builds.csv"
cp "$TEMP_DIR/Database.txt.4" "$CSV_DIR/skill_builds.csv"
cp "$TEMP_DIR/Database.txt.5" "$CSV_DIR/skill_usage.csv"
cp "$TEMP_DIR/Database.txt.6" "$CSV_DIR/attack_target.csv"
cp "$TEMP_DIR/Database.txt.7" "$CSV_DIR/team_desires.csv"
cp "$TEMP_DIR/Database.txt.8" "$CSV_DIR/player_desires.csv"
