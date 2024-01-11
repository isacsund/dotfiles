# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Be nice to sysadmins
if [ -f /etc/bashrc ]
then
	source /etc/bashrc
elif [ -f /etc/bash.bashrc ]
then
	source /etc/bash.bashrc
fi

# History management
export HISTCONTROL=ignoreboth
export HISTSIZE=5000

# Better prompt
GIT_PS1_SHOWDIRTYSTATE=1
export PS1='[\u@\h \W\e[0;36m$(__git_ps1 " (%s)")\e[0m]\$ '
