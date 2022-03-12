#!/usr/bin/env bash
#
# I Should write something useful here but... i don't want to. :)
#
if [ "$(id -u)" = 0 ]; then
    echo "##################################################################"
    echo "This script MUST NOT be run as root user since it makes changes"
    echo "to the \$HOME directory of the \$USER executing this script."
    echo "The \$HOME directory of the root user is, of course, '/root'."
    echo "We don't want to mess around in there. So run this script as a"
    echo "normal user. You will be asked for a sudo password when necessary."
    echo "##################################################################"
    exit 1
fi

echo "################################################################"
echo "##                    Updating the system                     ##"
echo "################################################################"
sudo eopkg up || error "Error. The script couldn't update your system."

echo "###########################################################"
echo "## Installing the Packages. This may take a few minutes. ##"
echo "###########################################################"
sudo eopkg it dmenu git neofetch i3 dunst vim i3status i3lock feh flameshot picom light font-awesome-4 arandr fish zsh micro iw || error "Error: We couldn't download the packages."
sudo pip3 install bumblebee-status netifaces || error "Error: We couldn't download some packages."

clear

echo "################################################################"
echo "##    Copying configuration files to \$HOME                   ##"
echo "################################################################"

mkdir /home/$USER/.config/alacritty/
cd /home/$USER/.config/alacritty/
wget https://raw.githubusercontent.com/Jocadbz/dotfiles/main/alacritty/alacritty.yml || error "We couldn't download one of the config files"

mkdir /home/$USER/.config/dunst/
cd /home/$USER/.config/dunst/
wget https://raw.githubusercontent.com/Jocadbz/dotfiles/main/dunst/dunstrc || error "We couldn't download one of the config files"

mkdir /home/$USER/.config/i3/
cd /home/$USER/.config/i3/
wget https://raw.githubusercontent.com/Jocadbz/dotfiles/main/i3/config || error "We couldn't download one of the config files"

cd /home/$USER/
wget https://raw.githubusercontent.com/Jocadbz/dotfiles/main/.zshrc || error "We couldn't download one of the config files"

cd /home/$USER/.config/
wget https://raw.githubusercontent.com/Jocadbz/dotfiles/main/picom.conf || error "We couldn't download one of the config files"

cd /etc/
sudo wget https://raw.githubusercontent.com/Jocadbz/dotfiles/main/i3status.conf || error "We couldn't download one of the config files"
clear


echo "################################################################"
echo "##                    Installing SpaceVim                     ##"
echo "################################################################"
wait 2
cd /home/$USER/
curl -sLf https://spacevim.org/install.sh | bash
clear

echo "################################################################"
echo "##   Installing extra packages and executing extra commands   ##"
echo "################################################################"
git clone https://gitlab.com/dwt1/shell-color-scripts.git
cd shell-color-scripts
rm -rf /opt/shell-color-scripts || return 1
sudo mkdir -p /opt/shell-color-scripts/colorscripts || return 1
sudo cp -rf colorscripts/* /opt/shell-color-scripts/colorscripts
sudo cp colorscript.sh /usr/bin/colorscript
clear
chsh -s /bin/zsh




