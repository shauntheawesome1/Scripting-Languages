This script add.jl adds numbers from standard input.

code
Sum = 0                      # initialize accumulator
for Num in eachline(STDIN)   # loop over all input lines
  Sum += parse(Int, Num)     # convert to integer, add to accumulator
end                          # end of for loop
println(Sum)                 # output with newline
usage
Add numbers from keyboard:

julia add.jl
6
7
8
^D
Add numbers piped from another command:

ls -ld *   # long listing
ls -ld * | tr -s ' '   # reduce consecutive runs of spaces to a single space
ls -ld * | tr -s ' ' | cut -d ' ' -f 5   # output only size field
ls -ld * | tr -s ' ' | cut -d ' ' -f 5 | julia add.jl   # add sizes
disk hog
This script hog.jl reports disk use sorted by size. It takes one argument, the directory to search.

code
# if > 0 args set homes to 1st arg, otherwise to "/home" (default)
homes = length(ARGS) > 0 ? ARGS[1] : "/home"

# set accts to list of directories in homes
accts = readdir(homes)

# let julia run command in, send errors to null, open a pipe for command output
pipe =  open(pipeline(`du -s $homes/$accts`, stderr=DevNull))

# read 1st element of tuple from pipe to outstr, 2nd element is process
# chomp removes trailing newline
outstr = chomp(readstring(pipe[1]))

# split string into array of substrings (whitespace delimited)
outarr = split(outstr)

# resize 1 dimensional array to 2 dimensions
out2d = reshape(outarr,(2,:))

# sort array by colums using integer value of 1st element (size)
outsrt = sortcols(out2d, by = x -> parse(Int, x[1]))

# loop over columns (2nd dimension), print row value, tab, column value, newline
for i in 1:(size(outsrt,2))
  @printf("%s\t%s\n", outsrt[2,i], outsrt[1,i])
end
usage
julia hog.jl /home1
