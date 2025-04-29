#!/usr/bin/env bash
# shellcheck disable=SC1090

# Exit immediately if a command exits with a non-zero status
set -e

# Give people a chance to retry running the installation
trap 'echo "Omakub installation failed! You can retry by running: source ~/.local/share/omakub/install.sh"' ERR

# Check the distribution name and version and abort if incompatible
source ~/.local/share/omakub/install/check-version.sh

# Ask for app choices
echo "Get ready to make a few choices..."
source ~/.local/share/omakub/install/terminal/required/app-gum.sh >/dev/null
source ~/.local/share/omakub/install/first-run-choices.sh

# Needed for all installers
sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get install -y curl git unzip

# Create needed directories
mkdir -p ~/.local/bin

# Desktop software and tweaks will only be installed if we're running Gnome or Cosmic
if [[ "$XDG_CURRENT_DESKTOP" == *"GNOME"* || "$XDG_CURRENT_DESKTOP" == *"COSMIC"* ]]; then
  # Store initial values for idle and lock settings
  LOCK_ENABLED=$(gsettings get org.gnome.desktop.screensaver lock-enabled)
  IDLE_DELAY=$(gsettings get org.gnome.desktop.session idle-delay | awk '{print $2}')

  # Ensure computer doesn't go to sleep or lock while installing
  gsettings set org.gnome.desktop.screensaver lock-enabled false
  gsettings set org.gnome.desktop.session idle-delay 0

  echo "Installing terminal and desktop tools..."

  # Install terminal tools
  source ~/.local/share/omakub/install/terminal.sh

  # Install desktop tools and tweaks
  source ~/.local/share/omakub/install/desktop.sh

  # Revert to normal idle and lock settings
  gsettings set org.gnome.desktop.screensaver lock-enabled "$LOCK_ENABLED"
  gsettings set org.gnome.desktop.session idle-delay "$IDLE_DELAY"
else
  echo "Only installing terminal tools..."
  source ~/.local/share/omakub/install/terminal.sh
fi
