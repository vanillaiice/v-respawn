#!/bin/sh
echo "Compiling example program 'hi'"
v example.v
echo "Running example:"
../bin/respawn --program example --max-retry 2 --retry-time 3 --args '-n Ed Edd Eddy'

# The following syntax for the argument 'args' (--name instead of -n), does not work for some reason -_- 
# ../bin/respawn --program hi --max-retry 2 --retry-time 3 --args "--name Ed Edd Eddy"
