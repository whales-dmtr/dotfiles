if status is-interactive
    # Commands to run in interactive sessions can go here
end

set -x PATH (pyenv root)/shims $PATH

# Aliases
alias tmuxs "~/.config/tmux/plugins/tmux-sessionizer/sessionizer.bash"
alias sv "source /opt/custom/sovenv.fish"

### Abbreviations

# Git
abbr --add c clear
abbr --add gs git status
abbr --add gl git log 
abbr --add glo git log --oneline
abbr --add gc git commit -m 
abbr --add gca git commit --amend
abbr --add gg git checkout
abbr --add ga git add
abbr --add gaa git add .
abbr --add gp git push origin
abbr --add gpm git push origin master

# System
abbr --add sf source ~/.config/fish/config.fish

# Custom prompt with starship
starship init fish | source

# Add plugin zoxide
zoxide init fish | source


