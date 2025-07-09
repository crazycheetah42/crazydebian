username="${SUDO_USER:-$USER}"

echo "Installing crazydebian bspwm"
sudo apt update && sudo apt full-upgrade -y

echo "Copying config files"
mkdir /home/$username/.fonts
cp -r dotconfig/* /home/$username/.config/
cp -r dotfonts/* /home/$username/.fonts/

echo "Installing packages"
sudo apt install bspwm feh sxhkd alacritty rofi polybar picom thunar lxpolkit x11-xserver-utils unzip wget curl pulseaudio -y
sudo apt install neofetch flameshot fonts-font-awesome psmisc lxappearance pavucontrol papirus-icon-theme fonts-noto-color-emoji lightdm -y
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt install ./google-chrome-stable_current_amd64.deb -y

echo "Setting up themes"
cd /usr/share/themes/
git clone https://github.com/EliverLara/Nordic.git
cd $builddir
git clone https://github.com/alvatip/Nordzy-cursors
cd Nordzy-cursors
./install.sh
cd $builddir
rm -rf Nordzy-cursors

echo "Setting up fonts"
fc-cache -vf

echo "Setting up login screen (lightdm)"
sudo systemctl enable lightdm
sudo systemctl set-default graphical.target

echo "Making bspwm and sxhkd executable"
chmod +x /home/$username/.config/bspwm/bspwmrc
chmod +x /home/$username/.config/sxhkd/sxhkdrc

echo "Installed! Please run 'sudo reboot' to reboot your computer and make sure to login to bspwm instead of the Default Xsession"