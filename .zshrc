# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/isac/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

autoload -U promptinit; promptinit
prompt spaceship

# Spaceship configuration
SPACESHIP_PROMPT_SEPARATE_LINE=false
SPACESHIP_CHAR_SYMBOL=""
SPACESHIP_GOLANG_SYMBOL=""

source "$HOME/.config/zsh/abbreviations.zsh"

# Export PATHs
export GOPATH=$HOME/Projects/go

export PATH="$PATH:$(yarn global bin)"
export PATH=/home/isac/.mix/escripts:$PATH
export PATH="$HOME/.cargo/bin:$PATH"
# Aliases
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
