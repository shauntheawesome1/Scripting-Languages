add
This script add.bash adds numbers from standard input.

code
Sum=0   # initialize accumulator

while read Num ; do   # loop while input exists assigning each line to Num
  Sum=$(( $Sum + $Num ))   # add input number to Sum
done   # end of while block

echo $Sum   # print total
usage
Add numbers from keyboard:

bash add.bash
6
7
8
^D
Add numbers piped from another command:

ls -ld *   # long listing
ls -ld * | tr -s ' '   # reduce consecutive runs of spaces to a single space
ls -ld * | tr -s ' ' | cut -d ' ' -f 5   # output only size field
ls -ld * | tr -s ' ' | cut -d ' ' -f 5 | bash add.bash   # add sizes
disk hog
This script hog.bash reports disk use sorted by size. It takes one argument, the directory to search.

code
# paramater expansion with default value, $1 is 1st command line argument
# if $1 exists set Homes to $1, otherwise to /home
Homes=${1:-/home}

# assign each command output line to 2 array elements, account size and name
Accounts=($(du -s $Homes/* 2> /dev/null | sort -k1nr))

# C-style for loop over pairs of array elements
# account names are odd-numbered elements, sizes are even-numbered elements
# -e enables escapes, \t is tab
for (( Index=0 ; Index < ${#Accounts[@]} ; Index+=2 )) ; do
  echo -e "${Accounts[Index+1]}\t${Accounts[Index]}"
done
usage
bash hog.bash /home1
