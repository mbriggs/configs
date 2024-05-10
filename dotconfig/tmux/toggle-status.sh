#!/bin/bash

# Get the number of windows
num_windows=$(tmux list-windows | wc -l)

# Check if the number of windows is greater than 1
if [ "$num_windows" -gt 1 ]; then
	tmux set-option status on
else
	tmux set-option status off
fi
