
sudo dnf install gnome-extensions-app gnome-tweaks shotwell gnome-themes-extra -y

# download nerd font
#
curl --create-dirs -fLO --output-dir ~/.local/share/fonts https://github.com/ryanoasis/nerd-fonts/raw/HEAD/patched-fonts/JetBrainsMono/Ligatures/Regular/JetBrainsMonoNerdFontMono-Regular.ttf
gsettings set org.gnome.desktop.interface monospace-font-name 'JetBrainsMono Nerd Font 10'

# set cursor theme
#
git clone https://github.com/alvatip/Sunity-cursors /tmp/sunity/
mv /tmp/sunity/Sunity-cursors ~/.icons/Sunity-cursors/
mv /tmp/sunity/Sunity-cursors-white ~/.icons/Sunity-cursors-white/
gsettings set  org.gnome.desktop.interface cursor-theme 'Sunity-cursors'

# download icon theme
# 
sudo dnf install -y papirus-icon-theme
gsettings set org.gnome.desktop.interface icon-theme 'Papirus'

# other settings 
gsettings set org.gnome.desktop.interface clock-format '12h'
gsettings set org.gnome.desktop.wm.preferences button-layout ":minimize,maximize,close"
gsettings set org.gnome.mutter center-new-windows true
gsettings set org.gnome.desktop.input-sources xkb-options '["caps:ctrl_modifier"]'


