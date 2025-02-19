#!/usr/bin/env bash

# tmux sessionizer, based on https://github.com/theprimeagen/.dotfiles/blob/master/bin/.local/scripts/tmux-sessionizer

if [[ $# -eq 1 ]]; then
    selected=$1
else
    depth_0=$(find ~/dotfiles ~/scratch ~/notes -mindepth 0 -maxdepth 0 -type d)
    depth_1=$(find ~/projects ~/gits ~/work -mindepth 1 -maxdepth 1 -type d)
    # replace $home with ~ for brevity
    dirs=$(echo -e "$depth_0\n$depth_1" | sed "s|^$home|~|g")
    selected=$(echo "$dirs" | fzf)
fi

if [[ -z $selected ]]; then
    exit 0
fi

selected_name=$(basename "$selected" | tr . _)

if ! tmux has-session -t=$selected_name 2>/dev/null; then
    # tmux doesn't have this session, so create
    # replace ~ back to $home so tmux can understand the path
    full_path=$(echo "$selected" | sed "s|^~|$home|")
    tmux new-session -ds "$selected_name" -c "$full_path"
fi

if [[ -z $tmux ]]; then
    # we're not in tmux, so attach
    tmux attach -t "$selected_name"
else
    # we're in tmux, so switch
    tmux switch-client -t "$selected_name"
fi
