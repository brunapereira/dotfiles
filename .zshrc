# ZSH Specifics {{{
export ZSH="$HOME/.oh-my-zsh" # Path to your oh-my-zsh installation.

ZSH_THEME="robbyrussell" # Theme
plugins=(git z)

source $ZSH/oh-my-zsh.sh
# }}}

# Define aliases here! {{{
alias ez="vim $HOME/.zshrc"
alias sz="source $HOME/.zshrc"
alias ev="vim ~/dotfiles/init.vim"

# Alias to open nvim instead of vim
alias vim="nvim"
alias vvim="\vim"
# }}}

# Export variables here! {{{
export MYVIMRC="$HOME/.config/nvim/init.vim"
export GPG_TTY=$(tty)
export PINENTRY_USER_DATA="USE_CURSES=1"
export CGO_LDFLAGS_ALLOW=".*"
export GO_PATH=$HOME/go
# }}}

# Update Path Here! {{{
export PATH=$PATH:$HOME/nvim-osx64/bin:$HOME/go:$GO_PATH/bin
# }}}

# Ripgrep + FZF {{{
export FZF_DEFAULT_COMMAND="rg --files --hidden --follow --glob '!.git'"
# }}}

# Fancy ctrl z {{{
function fancy-ctrl-z () {
  if [[ $#BUFFER -eq 0 ]]; then
    BUFFER="fg"
    zle accept-line
  else
    zle push-input
    zle clear-screen
  fi
}
zle -N fancy-ctrl-z
bindkey '^Z' fancy-ctrl-z
# }}}

# Firm specifics {{{
#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
eval "$(pyenv init -)"
source $HOME/.nurc
# BEGIN ANSIBLE MANAGED BLOCK - RBENV
eval "$(rbenv init -)"
# END ANSIBLE MANAGED BLOCK - RBENV
# }}}
