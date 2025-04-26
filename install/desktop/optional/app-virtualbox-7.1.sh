# Virtualbox allows you to run VMs for other flavors of Linux or even Windows
# See https://ubuntu.com/tutorials/how-to-run-ubuntu-desktop-on-a-virtual-machine-using-virtualbox#1-overview
# for a guide on how to run Ubuntu inside it.

# Remove any existing old VirtualBox installation
sudo apt remove -y virtualbox virtualbox-ext-pack 2>/dev/null || true

# Install Virtualbox 7.1
curl -sS https://www.virtualbox.org/download/oracle_vbox_2016.asc | \
sudo gpg --yes --dearmor --output /usr/share/keyrings/oracle-virtualbox-2016.gpg

echo "deb [arch=amd64 signed-by=/usr/share/keyrings/oracle-virtualbox-2016.gpg] http://download.virtualbox.org/virtualbox/debian $(. /etc/os-release && echo "$VERSION_CODENAME") contrib" | sudo tee /etc/apt/sources.list.d/virtualbox.list
sudo apt update && sudo apt install -y virtualbox-7.1

# Install VirtualBox 7.1.x Extension Pack
VBOX_VERSION=$(virtualbox --help | head -n 1 | awk '{print substr($NF, 2)}')
curl -L -o /tmp/Oracle_VirtualBox_Extension_Pack-"$VBOX_VERSION".vbox-extpack "https://download.virtualbox.org/virtualbox/$VBOX_VERSION/Oracle_VirtualBox_Extension_Pack-$VBOX_VERSION.vbox-extpack"

# Extract just ExtPack-license.txt from the archive into /tmp
mkdir -p /tmp/vbox_extpack_extract
tar -xzf /tmp/Oracle_VirtualBox_Extension_Pack-"$VBOX_VERSION".vbox-extpack -C /tmp/vbox_extpack_extract
SHA256SUM=$(sha256sum /tmp/vbox_extpack_extract/ExtPack-license.txt | awk '{print $1}')

# Install it
sudo vboxmanage extpack install --replace /tmp/Oracle_VirtualBox_Extension_Pack-"$VBOX_VERSION".vbox-extpack --accept-license="$SHA256SUM"

# Clean Up
rm -rf /tmp/vbox_extpack_extract Oracle_VirtualBox_Extension_Pack-*

sudo usermod -aG vboxusers ${USER}
