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

def get_value(word):
  return word.strip() if not word.lstrip("-").isdigit() else None

def parse_lines(reader):
  skip_header_lines(reader)

  dictionary = set()

  for line in reader:
    for word in line:
      word = get_value(word)
      if word: dictionary.add(word)

  sorted(dictionary)

  return dictionary

def write_dictionary(dictionary_file, dictionary):
  with open(dictionary_file, "a") as file_obj:
    for word in dictionary:
        file_obj.write(word + "\n")

def generate_dictionary(check_file, dictionary_file):
  with open(check_file, "rU") as file_obj:
    reader = csv.reader(file_obj, delimiter=';')
    dictionary = parse_lines(reader)
    write_dictionary(dictionary_file, dictionary)

def check_lines(reader, dictionary):
  skip_header_lines(reader)

  for line in reader:
    for word in line:
      word = get_value(word)
      if word and not word in dictionary:
        sys.stderr.write("Undefined word: %s\n" % word)

def check(check_file, dictionary_file):
  with open(dictionary_file, "rU") as file_obj:
    dictionary = file_obj.read().splitlines()

  with open(check_file, "rU") as file_obj:
    reader = csv.reader(file_obj, delimiter=';')
    check_lines(reader, dictionary)

def main():
  if len(sys.argv) == 4:
    check_file = sys.argv[1]
    dictionary_file = sys.argv[2]
    is_first_run = True if int(sys.argv[3]) == 1 else False
  else:
    print_usage(_USAGE)

  if is_first_run:
    generate_dictionary(check_file, dictionary_file)
  else:
    check(check_file, dictionary_file)

if __name__ == '__main__':
  main()
