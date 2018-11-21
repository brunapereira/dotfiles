export ZSH=/Users/bpereira/.oh-my-zsh
ZSH_THEME="robbyrussell"

# Plugins
plugins=(git z)

source $ZSH/oh-my-zsh.sh

export EDITOR='vim'

#
# ALIASES
#

alias ez="vim ~/.zshrc"
alias sz="source ~/.zshrc"

if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

export JAVA_HOME=$(/usr/libexec/java_home)

export NVM_DIR="/Users/bpereira/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
