#!/bin/bash


# Setup script

echo ">>> Setting Z-Shell as default shell"
if ! [ -n "$ZSH_VERSION" ]; then
  echo "before proceeding with the configuration, install the zsh package."
fi


SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
echo "Setup script directory: $SCRIPT_DIR"


# .config
echo ">>> Moving configuration files folder to $HOME/.config/"
mkdir -p $HOME/.config
mv $SCRIPT_DIR/.config/* $HOME/.config/
rmdir .config


# download latest neovim .deb if using APT
if [ -f /etc/apt/sources.list ]; then
  echo ">>> Downloading latest neovim .deb package (since APT usually has older neovim versions)"

  url=$(curl -s https://api.github.com/repos/neovim/neovim/releases/latest | grep "browser_download_url.*deb" | cut -d : -f 2,3 | tr -d \")
  curl -L -o neovim-latest.deb $url

  echo "Run: \n\n\tsudo apt-get -f install ./neovim-latest.deb\n\n"
fi


# environment vars
echo ">>> Moving .zshenv to $HOME"
mv $SCRIPT_DIR/.zshenv $HOME


# activating zshell
source $HOME/.config/zsh/.zshrc


git switch dev-main


echo "Finished setup. Run the command:\n\n  chsh -s \$(which zsh)  \n\nand log out to apply changes."
