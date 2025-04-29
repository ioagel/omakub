sudo apt install -y flatpak
if [[ "$XDG_CURRENT_DESKTOP" == *"GNOME"* ]]; then
  sudo apt install -y gnome-software-plugin-flatpak
fi
sudo flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
