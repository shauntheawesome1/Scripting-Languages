This script add.ex adds numbers from standard input.

code
String.split(IO.read(:stdio, :all))            # read STDIN, split into list
|> Enum.map(fn x -> String.to_integer(x) end)  # convert strings to integers
|> Enum.reduce(fn x, acc -> x + acc end)       # add integers together
|> IO.puts                                     # print
usage
Add numbers from keyboard:

elixir add.ex
6
7
8
^D
Add numbers piped from another command:

ls -ld *   # long listing
ls -ld * | tr -s ' '   # reduce consecutive runs of spaces to a single space
ls -ld * | tr -s ' ' | cut -d ' ' -f 5   # output only size field
ls -ld * | tr -s ' ' | cut -d ' ' -f 5 | elixir add.ex   # add sizes
disk hog
This script hog.ex reports disk use sorted by size. It takes one argument, the directory to search.

code
# if arg list not empty set homes to 1st arg, otherwise to "/home"
homes = System.argv != [] && hd(System.argv) || "/home"

# let elixir return a listing of homes
File.ls(homes)

# |> is pipe to 1st arg of function, extract 2nd element (output, 1st is status)
|> elem(1)

# map replaces each element of an enumerable with the result of the funtion
# cmd lets elixir run a command followed by a list of options and args
# #{ } is interpolation, stderr_to_stdout is an elixir option
|> Enum.map(fn x -> System.cmd("du", ["-s"] ++ ["#{homes}/#{x}"], stderr_to_stdout: true) end)

# replace each input tuple with just its 1st element (string, 2nd is result) 
# ~r encloses a rexexp which replaces error messages with empty strings
|> Enum.map(fn x -> elem(x,0) |> String.replace(~r|^(/usr/bin/du:.*\n)+|, "") end)

# split each input string into a list (whitespace delimited)
|> Enum.map(fn x -> String.split(x) end)

# sort each input list by integer value of first element (head), largest first
|> Enum.sort(fn x,y -> String.to_integer(hd(y)) <= String.to_integer(hd(x)) end)

# join each input list into a string (tab between elements), print with newline 
|> Enum.each(fn x -> IO.puts(Enum.join(x, "\t")) end)
usage
elixir hog.ex /home1
