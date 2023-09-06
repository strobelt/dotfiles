#!/bin/bash

sudo apt update
sudo apt install -y git

git -C $HOME clone --branch debian https://github.com/strobelt/dotfiles.git .dotfiles
if [ $? -eq 0 ] ; then
    (cd $HOME/.dotfiles/ ; /bin/bash ./setup.sh)
fi
