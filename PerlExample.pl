This script add.pl adds numbers from standard input.

code
use strict ;   # enable error checking
use warnings ;   # enable more error checking

my $Sum = 0 ;  # initialize accumulator (scaler, local scope)

$Sum += $_ for <STDIN> ;   # one-line foreach loop
                           # < > is file read operator
                           # $_ is default loop variable, add to accumulator

print "$Sum\n" ;   # explicit newline
usage
Add numbers from keyboard:

perl add.pl
6
7
8
^D
Add numbers piped from another command:

ls -ld *   # long listing
ls -ld * | tr -s ' '   # reduce consecutive runs of spaces to a single space
ls -ld * | tr -s ' ' | cut -d ' ' -f 5   # output only size field
ls -ld * | tr -s ' ' | cut -d ' ' -f 5 | perl add.pl   # add sizes
disk hog
This script hog.pl reports disk use sorted by size. It takes one argument, the directory to search.

code
# get more errors and warnings
use strict ;
use warnings ;

# if > 0 args set scaler $Homes to 1st arg, otherwise to '/home' (default)
my $Homes = $#ARGV >= 0 ? $ARGV[0] : '/home' ;

# run shell command, output to array @Output
my @Output = `du -s $Homes/* 2> /dev/null | sort -k1nr` ;

# remove trailing newline
chomp(@Output) ;

# Loop over array elements, split strings to subarrays, print reversed
foreach my $Acct ( @Output ) {
  my @Line = split("\t",$Acct) ;
  print "$Line[1]\t$Line[0]\n" ;
}
usage
perl hog.pl /home1
