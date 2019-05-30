This script add.tcl adds numbers from standard input.

code
set Sum 0   # initialize accumulator

foreach Num [read stdin] {   # read STDIN, loop assigning each line to Num 
  incr Sum $Num   # increment Sum by value of Num
}   # end of foreach block

puts $Sum
usage
Add numbers from keyboard:

tclsh add.tcl
6
7
8
^D
Add numbers piped from another command:

ls -ld *   # long listing
ls -ld * | tr -s ' '   # reduce consecutive runs of spaces to a single space
ls -ld * | tr -s ' ' | cut -d ' ' -f 5   # output only size field
ls -ld * | tr -s ' ' | cut -d ' ' -f 5 | tclsh add.tcl   # add sizes
disk hog
This script hog.tcl reports disk use sorted by size. It takes one argument, the directory to search.

code
# $ is variable substitution, [ ] is command substitution, { } is quote
# if > 0 args set $Homes to 1st arg, otherwise to "/home" (default)
set Homes [ expr { ( $argc > 0 ) ?  [ lindex $argv 0 ] : "/home" } ]

# run shell command using catch to continue if command returns errors
# let Tcl expand the wildcard, store command output in Result list
catch { exec du -s {*}[ glob $Homes/* ] 2> /dev/null | sort -k1nr } Result Error

# C-style for loop, iterate over pairs of elements (2 elements per account)
# stop on reaching "child process terminated abnormally"
# output 2nd element (name), tab, 1st element (size)
for { set Index 0 } { $Index < [ llength $Result ] } { incr Index 2 } {
  if { [ lindex $Result $Index ] == "child" } break
  puts "[ lindex $Result [ expr $Index + 1 ] ]\t[ lindex $Result $Index ]"
}
usage
tclsh hog.tcl /home1
