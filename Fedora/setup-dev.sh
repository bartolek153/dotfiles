
# enable repositories
#

# code repo
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'

# lazygit repo
sudo dnf copr enable atim/lazygit

# docker repo
sudo dnf config-manager \
    --add-repo \
    https://download.docker.com/linux/fedora/docker-ce.repo


# packages installation
#
sudo dnf install -y docker docker-compose-plugin \
  code \
  lazygit gh glab \
  dotnet \
  golang \
  java-latest-openjdk.x86_64 \
  nodejs \
  python python-pip python-virtualenv \
  sqlite \
  redis \
  azure-cli


# docker post-installation setup
sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker
sudo systemctl enable docker.service
sudo systemctl enable containerd.service
docker run hello-world

# install yarn
sudo npm i -g yarn

  
# environment setup
# 


# move dotfiles
cp -r ../.config/* ~/.config/
cp -r ../.zshenv ~/ 

# neovim
sudo dnf install -y neovim ripgrep sed fd-find xclip unzip

rm -rf ~/.config/nvim
rm -rf ~/.local/share/nvim

# terminal/zsh
sudo dnf install -y zsh tmux bat ranger foot vifm  # exa
chsh -s $(which zsh)
source $HOME/.config/zsh/.zshrc

# ssh
cp /path/to/privatekey ~/.ssh 
chmod 400 ~/.ssh/privatekey

