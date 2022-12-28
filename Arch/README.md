# Packages List
## Essentials
```bash
 # Some Development Tools
sudo pacman -S base-devel
 
 # Important packages
sudo pacman -S man git wget zip curl make automake gcc micro libheif arch-wiki-cli

 # Enable AUR Helper
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si

git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si

 # Enable Flatpak Repository
sudo pacman -S flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
```


## Development
### *_Tools and Shell_*
```bash
 # Neovim
sudo pacman -S neovim ripgrep sed fd xclip unzip 
 
 # ZSH
sudo pacman -S zsh tmux exa bat ranger

 # Git-Related
sudo pacman -S lazygit github-cli
```


### *_Programming Languages_*
```bash
 # Dotnet CLI
sudo pacman -S dotnet-runtime mono

 # Python
sudo pacman -S python python-pip python-virtualenv

 # SQLite
sudo pacman -S sqlite

 # TeX
sudo pacman -S texlive-most
```


## Extras
```bash
sudo pacman -S asciiquarium btop cowsay cmatrix ffmpeg figlet htop ncdu ncmpcpp neofetch sl tree youtube-dl vifm

yay -S cava musikcube yt-dlp
```