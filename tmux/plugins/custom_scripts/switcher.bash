#!/usr/bin/env bash

session=`tmux ls | fzf`
session_name=${session%%:*}
tmux switch -t $session_name

