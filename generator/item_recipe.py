#!/usr/bin/env python

import sys
import csv
import common as c
import templates as t

_USAGE = """Usage: item_recipe.py <in_file>
    in_file - the item_recipe.csv file

Example:
    item_recipe.py database/csv/item_recipe.csv
"""

def skip_header_lines(reader):
  reader.next()

def print_header():
  sys.stdout.write(t.ITEM_RECIPE_HEADER)

def print_footer():
  sys.stdout.write(t.ITEM_RECIPE_FOOTER)

def get_value(line, index):
  return line[index].strip() if line[index] else 'nil'

def print_item_recipe(line):
  item_recipe = t.ITEM_RECIPE.replace('<item>', get_value(line ,0))
  item_recipe = item_recipe.replace('<component1>', get_value(line, 1))
  item_recipe = item_recipe.replace('<component2>', get_value(line, 2))
  item_recipe = item_recipe.replace('<component3>', get_value(line, 3))
  item_recipe = item_recipe.replace('<component4>', get_value(line, 4))

  sys.stdout.write(item_recipe)

def parse_lines(reader):
  skip_header_lines(reader)

  for line in reader:
    print_item_recipe(line)

def parse_csv_file(filename):
  with c.open_file(filename, "rU") as file_obj:
    reader = csv.reader(file_obj, delimiter=';')
    parse_lines(reader)

def main():
  if len(sys.argv) == 2:
    filename = sys.argv[1]
  else:
    c.print_usage(_USAGE)

  print_header()

  parse_csv_file(filename)

  print_footer()

if __name__ == '__main__':
  main()
