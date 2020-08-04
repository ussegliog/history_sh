#!/bin/bash

# Three functions to switch between modes :
# switch_to_global : dir to global 
# switch_to_dir : global to dir
# switch_to_other : dir to dir
switch_to_global()
{
    if [ "${HISTMODE}" = 'dir' ]
    then
        echo "Global history activted ! " 1>&2
	historyFileToggleToGlobal
    fi

}
switch_to_dir()
{
    if [ "${HISTMODE}" = 'global' ]
    then
        echo "Per directory history activted ! " 1>&2
	historyFileToggleToPerDir ${1}
    fi

}
switch_to_other_dir()
{
    echo "Per directory history activted ! " 1>&2
    historyFileToggleToPerDir ${1}
}


# Main function (${@} : list of parameters)
main()
{
    # if only cd (=> redirect to home => global)
    if [[ "${#}" == 0 ]]
    then
	directory=${HOME}/.bash_hisory
    fi

    # if argument => maybe a local history
    if [[ "${#}" -ge 1 ]]
    then
	# Check several options : cd .., cd -, cd ., cd ${1} (absolute/relative paths)
	if [[ "${1}" == ".." ]]
	then
	    directory=$(dirname ${PWD})/.history
	elif [[ "${1}" == "-" ]]
	then
	    directory=${OLDPWD}/.history
	elif [[ "${1}" == "." ]]
	then
	    directory=${PWD}/.history
	else
	    # difference between absolute and relative path
	    if [[ "${1:0:1}" == / || "${1:0:2}" == ~[/a-z] ]]
	    then
		# absolute
		directory=${1}.history
	    else
		# relative
		directory=${PWD}/${1}.history
	    fi
	  
	fi    
    fi

    # if two arguments : path and maybe hist (to change dir to other dir history)
    # if only one : path
    if [[ "${#}" == 2 ]]
    then
	# Check if second argument is "hist"
	if [[ "${2}" == "hist" ]]
	then
	    if [ -f "${directory}" ]
	    then
		switch_to_other_dir "${directory}"
	    fi
	fi
    else
	# if a local .history exists => switch to dir
	if [ -f "${directory}" ]
	then
            switch_to_dir "${directory}"
	else
	    # else check if it is a subdirectory of a local history
	    # => keep the local/dir mode
	    dir_histfile=$(dirname ${HISTFILE})
	    dir_next=$(dirname ${directory})
	    dir_next=$(realpath ${dir_next})
	    
	    if [ ! "${dir_next:0:${#dir_histfile}}" = "$dir_histfile" ]
	    then
		switch_to_global
	    fi
	fi
    fi
}


# Main program
source $HISTSCRIPS/history_guardian_toggle.sh

# main + "real" cd
main "${@}"
\cd "${@}"
