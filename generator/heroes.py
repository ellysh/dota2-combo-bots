#!/usr/bin/env python

import sys
import csv
import common as c

_USAGE = """Usage: heroes.py <in_file>
    in_file - the heroes.csv file

Example:
    heroes.py database/csv/heroes.csv
"""

def skip_header_lines(reader):
  reader.next()

def parse_lines(reader):
  skip_header_lines(reader)

  for line in reader:
    print line

def parse_csv_file(filename):
  with c.open_file(filename, "rU") as file_obj:
    reader = csv.reader(file_obj, delimiter=';')
    parse_lines(reader)

def main():
  if len(sys.argv) == 2:
    filename = sys.argv[1]
  else:
    c.print_usage(_USAGE)

  parse_csv_file(filename)

if __name__ == '__main__':
  main()
