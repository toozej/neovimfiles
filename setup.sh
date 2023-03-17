#!/bin/bash

rm -rf ~/.config/nvim/ ~/.local/share/nvim/
git clone https://github.com/toozej/neovimfiles.git ~/.config/nvim
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
nvim +PlugInstall +qall +'TSInstallSync go'
