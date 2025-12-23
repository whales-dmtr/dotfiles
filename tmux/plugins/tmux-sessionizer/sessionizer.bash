#!/usr/bin/env bash

project_dir=`find ~/Documents/programming/ ~/.config/ ~/Documents/obsidian/  -type d -print | fzf`
project_name=`basename $project_dir`

# Вывести путь папки в новую вкладку
# tmux neww bash -c "echo $project_dir $project_name & while [ : ]; do sleep 5; done"

# find ~/Documents/progrmming 

tmux has-session -t $project_name 2>/dev/null

if [ $? != 0 ]; then
    # Set up your session
    tmux new -c "$project_dir" -s "$project_name" -d
fi

# Attach to created session
tmux attach-session -t $project_name
tmux switch -t "$project_name"


