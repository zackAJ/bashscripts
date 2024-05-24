#   you must have git and grep on your linux machine
#   to delete git branches by pattern add this function to your bash config ~/.bashrc
#   then close and reopen your terminal
#   usage : bdelete [pattern]
bdelete(){
    if [ $# -eq 0 ] ; then
	echo 'no branch name specified'
	return 1
    fi

    branches=$(git branch -l | grep -v $(git branch --show-current) | grep "$1")

    if [ -z "$branches" ] ; then
    	echo 'no branches found'
	return 0
    fi
	
    if [ -n "$branches" ] ; then
	tput setaf 1
	echo -e "$branches \n"
	tput sgr0  

	echo "are you sure you want to delete these branches ? y/n"
	read arg
    fi	

    if [ "$arg" != "y" ] ; then
	echo 'aborted'
	return 0
    fi

    git branch -D $(git branch -l | grep -v $(git branch --show-current) | grep "$1")
}
