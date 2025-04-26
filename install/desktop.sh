# shellcheck disable=SC1090
# Run desktop installers
for installer in ~/.local/share/omakub/install/desktop/*.sh; do source "$installer"; done

# If currently running Gnome
if [[ "$XDG_CURRENT_DESKTOP" == *"GNOME"* ]]; then
  for gnome_installer in ~/.local/share/omakub/install/desktop/gnome/*.sh; do source "$gnome_installer"; done
fi

# Logout to pickup changes
gum confirm "Ready to reboot for all settings to take effect?" && sudo reboot
