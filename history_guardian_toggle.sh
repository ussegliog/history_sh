#!/bin/bash

# Toggle to per directory history mode or global mode
historyFileToggleToPerDir()
{
    # Keep global history and save it
    unset HISTFILE_GLOBAL
    export HISTFILE_GLOBAL=${HISTFILE}
    history -w ${HISTFILE_GLOBAL}

    # Adapt HistFile to the dir mode
    unset HISTFILE
    export HISTFILE=${1}
    unset HISTMODE
    export HISTMODE='dir'

    # Clear and Reload dir history for the current shell
    history -c
    history -r ${HISTFILE}
}

historyFileToggleToGlobal()
{
    # Store history into histFile (for the dir mode)
    history -w ${HISTFILE}
    unset HISTFILE

    # Change histfile to be at global mode
    export HISTFILE=${HISTFILE_GLOBAL}
    unset HISTMODE
    export HISTMODE='global'

    # Clear and Reload global history for the current shell
    history -c
    history -r ${HISTFILE}
}
