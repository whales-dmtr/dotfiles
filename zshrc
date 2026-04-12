typeset -U path

path=(
/Users/dimaoleynik/.pyenv/shims
/Users/dimaoleynik/go/bin
/opt/local/libexec/gnubin
/opt/local/bin
/Users/dimaoleynik/.local/share/bob/nvim-bin
/opt/homebrew/bin
/opt/homebrew/sbin
/opt/homebrew/Cellar/starship/1.24.0/bin
/usr/local/bin
/usr/local/go/bin
/Users/dimaoleynik/.local/bin
/opt/pmk/env/global/bin
/opt/homebrew/opt/postgresql@14/bin
/opt/homebrew/opt/llvm/bin
/opt/local/sbin
/Applications/kitty.app/Contents/MacOS
/Applications/LibreOffice.app/Contents/MacOS
/Applications/Visual Studio Code.app/Contents/Resources/app/bin
/usr/bin
/bin
/usr/sbin
/sbin
/Users/dimaoleynik/.config/sowon
/Users/dimaoleynik/kew
/Users/dimaoleynik/.cargo/bin
$path
)

# system
alias c="clear"
alias v="nvim"
alias t="tmux"
alias ta="tmux a"
alias o="open"
alias s="sowon"
alias so="source"

# git
alias gs="git status"
alias gl="git log"
alias glo="git log --oneline"
alias gc="git commit -m"
alias gca="git commit --amend"
alias gg="git checkout"
alias ga="git add"
alias gaa="git add ."
alias gp="git push origin"
alias gpm="git push origin master"

export DL=~/Downloads
export DX=~/Documents
export EDITOR=nvim
export CONFIG=~/.zshrc

source <(fzf --zsh)

bindkey -r '^A' 
bindkey -r '^E' 
bindkey '^A' beginning-of-line
bindkey '^E' end-of-line

export DYLD_LIBRARY_PATH="/opt/homebrew/lib${DYLD_LIBRARY_PATH:+:$DYLD_LIBRARY_PATH}"

autoload -Uz edit-command-line
zle -N edit-command-line
bindkey '^X^E' edit-command-line

eval "$(starship init zsh)"
eval "$(zoxide init zsh)"

. "$HOME/.local/bin/env"

alias c="clear"
