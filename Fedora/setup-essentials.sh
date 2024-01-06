
# change DNF configs
#
echo 'max_parallel_downloads=10' | sudo tee -a /etc/dnf/dnf.conf
notify-send "Your DNF config has now been amended" --expire-time=10

# enable RMP repos
#
sudo dnf -y install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
sudo dnf -y install https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

sudo dnf upgrade --refresh
sudo dnf groupupdate -y core
sudo dnf install -y dnf-plugins-core

# install essential packages
# 
sudo dnf -y install man git zip unzip gcc gcc-c++ which


notify-send "Essential packages installed and RPM Fusion Enabled" --expire-time=10

