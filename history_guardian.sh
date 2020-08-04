#!/bin/bash


# Usage for history_guardian command
usage()
{
    echo "Usage : history_guardian.sh <start/stop/scan>"
    echo "start : Activate per directory history mode for the current directory"
    echo "stop : Deactivate per directory history mode for the current directory"
    echo "scan : Scan for .history files to swicth to per directory history mode"
}

# Four options for history_command :
# historyToggle : To activate per dir history (create .history and change to dir mode)
# historyClean : To deactivate per dir history
# historyInfo : Get intel
# historyScan : Scan current directory to find local history files
historyToggle()
{
    if [ ! -f '.history' ]
    then
	touch .history
    fi

    historyFileToggleToPerDir ${PWD}/.history

    echo "Per directory history activated !" 1>&2

}
historyClean()
{
    historyFileToggleToGlobal

    echo "Global history activated !" 1>&2
}
historyInfo()
{
    echo "For your information :"
    echo "History mode is $HISTMODE"

    if [ $HISTMODE == "dir" ]
    then
	echo "HISTFILE is $HISTFILE"
    fi
}
historyScan()
{
    echo "Scan current direcotry to find local .history files"

    list=$(find $PWD -name '.history')

    echo ".history files found : "
    echo $list
}


# Main : Execute previous functions following user's choice
if [ "${#}" -ne 1 ]
then
    historyInfo
    usage
else
    source $HISTSCRIPS/history_guardian_toggle.sh

    if [ "${1}" = start ]
    then
	historyToggle

    elif [ "${1}" = stop ]
    then
	historyClean
    elif [ "${1}" = scan ]
    then
	 historyScan
    else
	usage
    fi
 
fi


