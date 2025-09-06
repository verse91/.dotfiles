#!/usr/bin/env bash

# Pushes all changes to the remote repository
cd ~/.dotfiles
git add .
git commit -m "Auto update dotfiles"
git push
