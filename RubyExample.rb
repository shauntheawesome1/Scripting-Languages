This script add.rb adds numbers from standard input.

code
# convert strings to integers
# accumulate sum by adding each line from STDIN
# print result
puts STDIN.inject {|sum, num| sum.to_i + num.to_i }
usage
Add numbers from keyboard:

ruby add.rb
6
7
8
^D
Add numbers piped from another command:

ls -ld *   # long listing
ls -ld * | tr -s ' '   # reduce consecutive runs of spaces to a single space
ls -ld * | tr -s ' ' | cut -d ' ' -f 5   # output only size field
ls -ld * | tr -s ' ' | cut -d ' ' -f 5 | ruby add.rb   # add sizes
disk hog
This script hog.rb reports disk use sorted by size. It takes one argument, the directory to search.

code
# if 1st arg not nil then set Homes to 1st arg, otherwise to "/home" (default)
Homes = ARGV[0] ? ARGV[0] : "/home"

# execute shell commend, return output
OutStr = %x[ du -s #{Homes}/* 2> /dev/null ]

# split string to list on newlines, split each resulting element to sublist
OutArr = OutStr.split("\n").map { |x| x.split }

# sort by negative integer value (reverse) of first sublist element
# print each sublist with elements reversed
OutArr.sort_by { |x| -x[0].to_i }.each { |x| puts "#{x[1]}\t#{x[0]}" }
usage
ruby hog.rb /home1
