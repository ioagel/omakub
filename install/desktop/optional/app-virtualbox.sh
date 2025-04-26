# Virtualbox allows you to run VMs for other flavors of Linux or even Windows
# See https://ubuntu.com/tutorials/how-to-run-ubuntu-desktop-on-a-virtual-machine-using-virtualbox#1-overview
# for a guide on how to run Ubuntu inside it.

# Remove any existing VirtualBox 7.1 installation
sudo apt remove -y virtualbox-7.1 2>/dev/null || true

sudo apt install -y virtualbox virtualbox-ext-pack
sudo usermod -aG vboxusers ${USER}
