#!/bin/bash
if [ "$EUID" -eq 0 ]
then
	echo "Error: please don't run as root, it messes up the installation. We will handle which command run as root"
fi

if ! python --version | grep -q 'Python 3.' 
then
    echo "Python 3 isn't installed so can't setup neovim. Sorry"
    exit 1
fi

if ! nvim -v > /dev/null
then
    echo "Installing neovim. Please note this script assumes we're using Fedora."
    sudo dnf install -y neovim
    sudo dnf install -y python3-neovim
else
    echo "Neovim already installed"
fi

echo "Creating nvim config directory"
mkdir -p ~/.config/nvim/autoload
mkdir -p ~/.config/nvim/plugged
wget "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
mv plug.vim ~/.config/nvim/autoload/
cp init.vim ~/.config/nvim/

pip install --user neovim
pip install --user flake8
pip install --user autopep8

echo "Please note when neovim may say there are errors when you first boot it."
echo "These is because the nvim package haven't been installed yet."
echo "Run the command :PlugInstall to fix the issue. Then restart neovim."
