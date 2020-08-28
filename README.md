# history_sh

Handle shell history with several levels : global or per directory

The command **history_guardian** allows : 
* To initialize a local history : *history_guardian start*
* To reload global history : *history_guardian stop* 
* To scan local histories : *history_guardian scan*

Once a local history is initialized, this history is automatically loaded with the *cd* command towards the local directory. You can change history with two local directories with *cd <new_local_dir> hist*

## Configuration

To override the history handle, the .bashrc has to be modified with :

---
HISTMODE="global"

HISTSCRIPS="<history_sh_path>"

alias history_guardian='source $HISTSCRIPS/history_guardian.sh'

alias cd='source $HISTSCRIPS/history_guardian_cd.sh'

---
