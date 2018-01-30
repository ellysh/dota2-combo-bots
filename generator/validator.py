#!/usr/bin/env python

import sys
import csv
import templates as t

_USAGE = """Usage: validator.py <check_file> <dictionary> <first_run>
    check_file - a CSV file to check
    dictionary - a TXT file with allowed words
    first_run - a 1/0 flag to initalize dictionary with current words

Example:
    validator.py database/csv/heroes.csv dictionary.txt
"""

def print_usage(usage):
  sys.stderr.write(usage)
  sys.exit(1)

def skip_header_lines(reader):
  reader.next()

def get_value(line, index):
  return line[index].strip() if line[index] else 'nil'

def print_element(line):
  sys.stdout.write(get_value(line, 0) + '\n')

def parse_lines(reader):
  skip_header_lines(reader)

  for line in reader:
    print_element(line)

def generate_dictionary(filename):
  with open(filename, "rU") as file_obj:
    reader = csv.reader(file_obj, delimiter=';')
    parse_lines(reader)

def main():
  if len(sys.argv) == 4:
    filename = sys.argv[1]
    dictionary = sys.argv[2]
    is_first_run = True if int(sys.argv[3]) == 1 else False
  else:
    print_usage(_USAGE)

  if is_first_run:
    generate_dictionary(filename)
  else:
    check_file(filename, dictionary)

if __name__ == '__main__':
  main()
