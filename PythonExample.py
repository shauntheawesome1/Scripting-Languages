versions
Python changed significantly with version 3, which is incompatible with earlier versions.

add
This script add.py adds numbers from standard input.

code
import sys   # use sys module
Sum = 0   # initialize accumulator
for Num in sys.stdin :   # loop over lines from STDIN
  Sum += int(Num)   # convert strings to integers, add to accumulator
                    # block defined by indentation
print Sum   # print
usage
Add numbers from keyboard:

python add.py
6
7
8
^D
Add numbers piped from another command:

ls -ld *   # long listing
ls -ld * | tr -s ' '   # reduce consecutive runs of spaces to a single space
ls -ld * | tr -s ' ' | cut -d ' ' -f 5   # output only size field
ls -ld * | tr -s ' ' | cut -d ' ' -f 5 | python add.py   # add sizes
disk hog
This script hog.py reports disk use sorted by size. It takes one argument, the directory to search.

code
# get functions from these modules
import sys, subprocess, glob

# if 1st arg exists set Homes to 1st arg, otherwise to '/home' (default)
Homes = sys.argv[1] if len(sys.argv) > 1 else '/home'

# command list, concatenate with +, let Python expand wildcard 
Cmd = ['du'] + ['-s'] + glob.glob(Homes + '/*')

# let Python open null device for writing
Null = open('/dev/null', 'w')

# empty list for appending
OutLst = []

# let Python run command without shell, output to pipe, errors to null
P1 = subprocess.Popen(Cmd, stdout=subprocess.PIPE, stderr=Null)

# read output (1st element of tuple) from pipe (2nd element is errors)
OutStr = P1.communicate()[0]

# strip final newline, iterate over list from splitting string at newlines
# split lines to sublists at tabs, reverse elements with negative index step
# append sublist to OutList 
for AcctStr in OutStr.rstrip('\n').split('\n') :
    AcctLst = AcctStr.split('\t')[::-1]
    OutLst += [AcctLst]

# function for sorting, negative integer value (reverse) od 2nd element
def sortkey(List) :
    return -int(List[1])

# sort lines using function, iterate
# join sublists to strings with tab between (method of tab), print
for Line in (sorted(OutLst, key=sortkey)) :
    print('\t'.join(Line))
usage
python hog.py /home1
