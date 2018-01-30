#!/bin/bash -x

set -e

CSV_DIR="database/csv"

./validator.py $CSV_DIR/heroes.csv dictionary.txt 1
