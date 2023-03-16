# neovimfiles

This is my `~/.config/nvim/` dir

## Installation
0. Clean up any pre-existing mess:
```
rm -rf ~/.config/nvim/ ~/.local/share/nvim/
```
1. Clone the repo:
```
git clone https://github.com/toozej/neovimfiles.git ~/.config/nvim
```
2. Install `vim-plug` plugin manager:
```
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
```
3. Run vim plugin installation:
```
nvim +PlugInstall +qall +'TSInstallSync go'
```
