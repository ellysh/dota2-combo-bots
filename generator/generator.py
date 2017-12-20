#!/usr/bin/env python

import sys
import csv
import common as c
import templates as t

_USAGE = """Usage: heroes.py <table> <column_number> <in_file>
    table - name of the table to generate
    column_number - number of columns in the table
    in_file - input CSV file

Example:
    generator.py HEROES 9 database/csv/heroes.csv
"""

def skip_header_lines(reader):
  reader.next()

def get_variable(table, suffix):
  return eval("t." + table + suffix)

def print_header(table):
  sys.stdout.write(t.HEADER)
  sys.stdout.write(get_variable(table, "_HEADER"))

def print_footer(table):
  sys.stdout.write(t.FOOTER)

def get_value(line, index):
  return line[index].strip() if line[index] else 'nil'

def print_element(table, column_number, line):
  element = get_variable(table, "")

  for i in range(0, column_number):
    element = element.replace('<' + str(i) + '>', get_value(line ,i))

  sys.stdout.write(element)

def parse_lines(table, column_number, reader):
  skip_header_lines(reader)

  for line in reader:
    print_element(table, column_number, line)

def parse_csv_file(table, column_number, filename):
  with c.open_file(filename, "rU") as file_obj:
    reader = csv.reader(file_obj, delimiter=';')
    parse_lines(table, column_number, reader)

def main():
  if len(sys.argv) == 4:
    table = sys.argv[1]
    column_number = int(sys.argv[2])
    filename = sys.argv[3]
  else:
    c.print_usage(_USAGE)

  print_header(table)

  parse_csv_file(table, column_number, filename)

  print_footer(table)

if __name__ == '__main__':
  main()
