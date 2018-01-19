#!/bin/bash

set -e

luacov
dos2unix *.out
