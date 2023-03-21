# DNF Configuration

/etc/dnf/dnf.conf

# Important DNF Commands

## Installation

- `dnf install` (any single package + dependencies)
- `dnf localinstall` (use .RPM downloaded file)
- `dnf groupinstall` (pre-defined group of packages)

## Uninstalling

- `dnf remove`

## Updating

- `dnf check-update [kernel]`
- `dnf update` (alias to dnf upgrade)
- `dnf upgrade`

## Others

- `dnf history`
- `dnf list all|<package_name>`
- `dnf search <package-name>`
- `dnf repolist all`

# Packages List

## Essentials

```bash
 # Some Development Tools
sudo dnf groupinstall "Development Tools"

 # Important packages
sudo dnf install man git zip curl make automake gcc gcc-c++ kernel-devel micro libheif

 # Enable RPM Fusion Repository (Free and Nonfree)
sudo dnf -y install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm

sudo dnf -y install https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

 # Enable Flatpak Repository
sudo dnf install flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
```

## Development

### _*Tools and Shell*_

```bash
 # Neovim
sudo dnf install neovim ripgrep sed fd-find xclip unzip

 # ZSH
sudo dnf install zsh tmux exa bat ranger

 # Docker
sudo dnf -y install dnf-plugins-core
sudo dnf config-manager \
    --add-repo \
    https://download.docker.com/linux/fedora/docker-ce.repo

sudo dnf install docker docker-compose-plugin

 # Git-Related
sudo dnf copr enable atim/lazygit -y

sudo dnf install lazygit gh
```

### _*Programming Languages*_

```bash
 # Dotnet CLI
sudo dnf install dotnet

 # Python
sudo dnf install python python-pip python-virtualenv

 # NodeJS
sudo dnf install nodejs

 # SQLite
sudo dnf install sqlite

 # TeX
sudo dnf install texlive
```

## Apps

```bash
sudo dnf install audacity chromium cpu-x gparted kdiskmark keepassxc peek qalculate-gtk qbittorrent vlc

 # Brave browser
sudo dnf install dnf-plugins-core
sudo dnf config-manager --add-repo https://brave-browser-rpm-release.s3.brave.com/x86_64/
sudo rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc
sudo dnf install brave-browser
```

## Gnome

```bash
sudo dnf install gnome-extensions-app gnome-tweaks
```

## Extras

```bash
sudo dnf install asciiquarium btop cowsay cmatrix cava ffmpeg figlet htop ncdu ncmpcpp neofetch qalculate sl toilet tree youtube-dlp vifm
```

## Flatpaks

```bash
flatpak install flathub com.spotify.Client
flatpak install flathub io.bassi.Amberol
flatpak install com.rafaelmardojai.Blanket
flatpak install flathub com.github.tchx84.Flatseal
flatpak install com.usebottles.bottles
flatpak install flathub org.musescore.MuseScore
flatpak install me.dusansimic.DynamicWallpaper
flatpak install io.github.lainsce.Notejot
flatpak install org.gimp.GIMP
flatpak install io.github.shiftey.Desktop.flatpakref
```
