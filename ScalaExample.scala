This script add.scala adds numbers from standard input.

code
import io.Source  // contains stdin

// read stdin, make it a string, split on newlines, convert to list,
// change strings to integers, add them up
println(Source.stdin.mkString.split("[\n]+").toList.map(x => x.toInt).sum)
usage
Add numbers from keyboard:

scala add.scala
6
7
8
^D
Add numbers piped from another command:

ls -ld *   # long listing
ls -ld * | tr -s ' '   # reduce consecutive runs of spaces to a single space
ls -ld * | tr -s ' ' | cut -d ' ' -f 5   # output only size field
ls -ld * | tr -s ' ' | cut -d ' ' -f 5 | scala add.scala   # add sizes
disk hog
This script hog.scala reports disk use sorted by size. It takes one argument, the directory to search.

code
// put objects from these modules in current scope
import sys.process._
import java.io.File

// val defines immutable value, var defines mutable variable
// if > 0 args set homes to 1st arg, otherwise to "/home" (default)
val homes = if (args.length > 0) args(0) else "/home"

// let scala get directory listing, convert to list of strings
val accts = new File(homes).listFiles.map(x => x.toString).toList

// construct command list
val cmd = "du" :: "-s" :: accts

// define logger (needed to suppress stderr)
val log = ProcessLogger(out => Nil, err => Nil)

// run command, capture output, convert to list of strings
val out = cmd.lineStream_!(log).toList

// convert list of strings to list of lists
val outlst = out.map(x => x.split("\t").toList)

// sort list by integer value of 1st item in each sublist, largest first
val outsrt = outlst.sortWith(_.head.toInt > _.head.toInt)

// print each line, 2nd element, tab, 1st element
outsrt.foreach(x => println(x.tail.head + "\t" + x.head))
usage
scala hog.scala /home1
