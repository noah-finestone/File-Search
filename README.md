# File-Search
A bash script for file search and content display.

The script, called searchFile.sh, searches for file names containing a specific string and has the option to display the file's contents. 
The command syntax is:
$ /searchFile.sh [-c] [-a] pattern [path]
Where:
-c displays the file's contents
-a displays all matching files, otherwise only one is shown
'path' is the directory to search within, if not specified the current directory is used
'pattern' is the string to search for in the file name (not contents)
An example of the output:

$ /searchFile.sh -c -a msg /mydata/scribbles
==== Contents of: /mydata/scribbles/msg2.txt ====
Hi, I am msg2.txt
Not all those who wander are lost.
==== Contents of: /mydata/scribbles/msg.txt ====
Hello there, I am msg.txt


