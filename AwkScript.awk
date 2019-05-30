add
This script add.awk adds numbers from standard input.

code
{ Sum += $1 }   # integer accumulator + 1st field of each input line
                # no loop, input read automatically
                # no initialization, new variables default to zero
END { print Sum }   # END matches after last input line
usage
Add numbers from keyboard:

awk -f add.awk
6
7
8
^D
Add numbers piped from another command:

ls -ld *   # long listing
ls -ld * | tr -s ' '   # reduce consecutive runs of spaces to a single space
ls -ld * | tr -s ' ' | cut -d ' ' -f 5   # output only size field
ls -ld * | tr -s ' ' | cut -d ' ' -f 5 | awk -f add.awk   # add sizes
disk hog
This script hog.awk reports disk use sorted by size. It takes one argument, the directory to search.

code
BEGIN {   # execute before reading any input

  # if 1st arg exists set Homes to 1st arg, otherwise to "/home" (default)
  Homes = ARGV[1] ? ARGV[1] : "/home"

  # | getline pipes shell command output to variable $0 (current line)
  # set record separator to null so all lines are read as one record
  RS = ""
  "du -s "Homes"/* 2> /dev/null | sort -k1nr" | getline

  # loop over pairs of fields in $0, NF = number of fields
  # account names are even-numbered fields, sizes are odd-numbered fields
  for ( I = 1 ; I < NF ; I += 2 )
    print $(I+1)"\t"$(I)
}
usage
awk -f hog.awk /home1
