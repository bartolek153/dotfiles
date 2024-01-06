
# GUI apps
# 
sudo dnf install -y audacity chromium cpu-x gparted kdiskmark keepassxc peek qalculate-gtk qbittorrent vlc

# set chromium as default browser
xdg-settings set default-web-browser chromium-browser.desktop


# CLI apps
# 
sudo dnf install -y btop ffmpeg-free htop ncdu neofetch qalculate tldr tree


# fun aps
# 
sudo dnf install -y asciiquarium cowsay cmatrix cava figlet ncmpcpp sl yt-dlp


# rpms
# 

# ytdlp-gui
curl --create-dirs -fLO --output-dir ~/Downloads/ytdlpgui/dlpgui.rpm https://github.com/BKSalman/ytdlp-gui/releases/download/v1.0.0/ytdlp-gui-1.0.0-1.x86_64.rpm
sudo dnf localinstall ~/Downloads/ytdlpgui/dlpgui.rpm

# min browser
curl --create-dirs -fLO --output-dir ~/Downloads/min/min.rpm https://github.com/minbrowser/min/releases/download/v1.30.0/min-1.30.0-x86_64.rpm
sudo dnf -i ~/Downloads/min/min.rpm

rm -r ~/Downloads/ytdlpgui
rm -r ~/Downloads/ytdlpgui


# enable flatpaks
# 
sudo dnf install flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
