# Isac's dotfiles

A collection of my personal dotfiles. Here's a little preview of what it can look like:
![Clean](https://i.imgur.com/PRfIbRd.png)

![Dirty](https://i.imgur.com/6ZfQ7D7.png)

## Installation
Add the alias to your .bashrc or .zshrc

    alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
    
Clone the repository

    git clone --bare https://github.com/isacsund/dotfiles.git ~/.dotfiles
    

Define the alias in the current shell scope:

    alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
    
Backup files that will be overwritten or remove them if you don't care

    mkdir -p .config-backup && \
    config checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | \
    xargs -I{} mv {} .config-backup/{}
    
Checkout the actual content from the bare repository to your $HOME:

    dotfiles checkout
