#!/usr/bin/env bash
# Install 1password and 1password-cli single script
TEMP_GPG_FILE=$(mktemp)
curl -sS https://downloads.1password.com/linux/keys/1password.asc |
    gpg --batch --yes --dearmor --output "$TEMP_GPG_FILE"
sudo install -o root -g root -m 644 "$TEMP_GPG_FILE" /usr/share/keyrings/1password-archive-keyring.gpg
rm "$TEMP_GPG_FILE"

# Add apt repository
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/1password-archive-keyring.gpg] https://downloads.1password.com/linux/debian/$(dpkg --print-architecture) stable main" |
    sudo tee /etc/apt/sources.list.d/1password.list

# Add the debsig-verify policy
sudo mkdir -p /etc/debsig/policies/AC2D62742012EA22/
curl -sS https://downloads.1password.com/linux/debian/debsig/1password.pol |
    sudo tee /etc/debsig/policies/AC2D62742012EA22/1password.pol
sudo mkdir -p /usr/share/debsig/keyrings/AC2D62742012EA22
TEMP_DEBSIG_GPG_FILE=$(mktemp)
curl -sS https://downloads.1password.com/linux/keys/1password.asc |
    gpg --batch --yes --dearmor --output "$TEMP_DEBSIG_GPG_FILE"
sudo install -o root -g root -m 644 "$TEMP_DEBSIG_GPG_FILE" /usr/share/debsig/keyrings/AC2D62742012EA22/debsig.gpg
rm "$TEMP_DEBSIG_GPG_FILE"

# Install 1Password & 1password-cli
sudo apt update && sudo apt install -y 1password 1password-cli
