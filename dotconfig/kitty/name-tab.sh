#!/bin/zsh

echo -n  "=> Set Tab Title: "
read new_tab_title

kitty @ set-tab-title "$new_tab_title"
