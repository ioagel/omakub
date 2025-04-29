sudo apt install -y flatpak
if [[ "$XDG_CURRENT_DESKTOP" == *"GNOME"* ]]; then
  sudo apt install -y gnome-software-plugin-flatpak
fi
sudo flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
flatpak remote-add --user --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

# To fix the XDG_DATA_DIRS warning temporarily for this session, before restarting
export XDG_DATA_DIRS=$XDG_DATA_DIRS:/var/lib/flatpak/exports/share:/home/$USER/.local/share/flatpak/exports/share