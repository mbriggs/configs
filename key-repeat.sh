#!/usr/bin/env bash  

# 15 is lowest setting on UI
defaults write -g InitialKeyRepeat -int 13

# 2 is lowest setting on UI
defaults write -g KeyRepeat -int 2

# allow holding key instead of mac default holding key to choose alternate key
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false
