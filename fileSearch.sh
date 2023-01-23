#checking if at least one argument was entered
if [[ $# -lt 1 ]] 
then
	#otherwise throw required message
	echo 'Error missing the pattern argument' 
fi

#checking if only 1 argument was entered 
if [[ 1 -eq $# ]]
then
	#check if the argument is either  -c, -a or a path, if so print error message
	if [[ $1 == "-c" ]] || [[ $1 == "-a" ]] || [[ -d "$2" ]]
	then
	echo 'Error missing the pattern argument.'
	#if it is just the pattern argument then run the following from the home directory
	else
		echo "`pwd`/$(ls| grep "$1")"
	fi
fi

#checking if 2 arguments were entered 
if [[ 2 -eq $# ]]
then
	#check if pattern argument was entered 
	if [[ $1 == "-c" ]] && [[ $2 == "-a" ]]
	then	
		echo 'Error missing the pattern argument'

	#second argument must be the pattern argument to run 
	elif [[ $1 == "-c" ]] 
	then
			#displaying content form the first file 
			echo "=== Contents of: `pwd` ==="
			cat "`ls $pwd| grep -m 1 \"$2\"`"
	
	#second argument must be the pattern argument to run 
	elif [[ $1 == "-a" ]] 
	then
		#checking that there are files that exist, otherwise go to else statement
		if [[ `ls | grep "$2"` != '' ]] 
		then
			#list the files that contain the pattern argument (argument 2) 
			echo "`ls | grep "$2"`"
		else
			echo "Unable to locate any files that has pattern $2 in its name in $PWD"
			exit 1
		fi
	#must be pattern argument then path 
	elif [[ $1 != "-c" ]] && [[ $2 != "-c" ]] && [[ $1 != "-a" ]] && [[ $2 != "-a" ]] 
	then
		echo "`ls | grep -m 1 "$2"`"		
	#checking if the directory entered exists 
	elif [[ ! -d $2 ]] 
	then
		#otherwise print error message
		echo "Error $2 is not a valid directory" 
		exit 1
	fi
fi

#check if 3 arguments were entered 
if [[ 3 -eq $# ]]
then	
	#3rd argument must be the pattern
	if [[ $1 == "-c" ]] && [[ $2 == "-a" ]]
	then
		matches=$(ls `pwd` | grep "$3") #this will return any matches and store them in a list  
		#checking that $matches is not empty
		if [[ -n "$matches" ]] 
		then
			echo "=== Content of: $matches ==="
			cat `ls $matches | grep $3`
		else
			#echo the required message
			echo "Unable to locate any files that has pattern $3 in its name in $PWD" 
		
		fi 
	#$2 must be the pattern and $3 must be the path 
	elif [[ $1 == "-c" ]] && [[ $2 != "-a" ]]
	then
		matches=$(ls "$3" | grep -m 1 "$2") 
		echo "`cat $3/$matches`"
	#checking conditions with either -c as $1 or $1 as -a where $2 is neither -a or -c
	elif [[ $1 == "-c" ]] && [[ $2 != "-a" ]] || [[ $1 == "-a" ]] && [[ $2 != "-c" ]]
	then
		if [[ ! -f "$2" ]] #if the file with the pattern does not exists 
		then	
			#output required message
			echo "Unable to locate any files that has pattern $2 in its name in $3"
			exit 1
		fi

	else 
		matches=$(ls "$3" | grep "$2") 	
		echo "$matches"		
	fi	
fi

#if all the arguments are inserted 
if [[ 4 -eq $# ]] 
then
	#list the files in argument 4 and check if the pattern (argument 3) is found in their names 
	matches=`ls "$4" | grep "$3"`
	for el in matches
	do 
		cat "$4/$el" # path/filename, print out all content in the specific file el
		echo $el 
	done 
fi
