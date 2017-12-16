import sys
import glob

# This function is needed to process wildcards on Windows
def open_file(filename, mode):
  return open(glob.glob(filename)[0], mode)

def print_usage(usage):
  sys.stderr.write(usage)
  sys.exit(1)
