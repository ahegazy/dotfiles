#!/bin/bash

gitPATH=$([[ -z $1 ]] && echo "$HOME/git/dotfiles" || echo $1);

cp $HOME/.config/i3/config $gitPATH/i3/config
cp $HOME/.config/i3status/config $gitPATH/i3status/config
cp $HOME/.config/rofi/config.rasi $gitPATH/rofi/
cp $HOME/.config/ranger/rc.conf $gitPATH/ranger/
cp $HOME/exec/* $gitPATH/exec/
cp $HOME/.local/bin/* $gitPATH/bin/
cp $HOME/.bashrc $gitPATH/
cp $HOME/.vimrc $gitPATH/
cp $HOME/.xpdfrc $gitPATH/
cp $HOME/.config/redshift.conf $gitPATH/redshift.conf
cp $HOME/.bash_profile $gitPATH/
