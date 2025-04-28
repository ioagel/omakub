if systemctl cat keyd.service >/dev/null 2>&1; then
    sudo systemctl disable keyd
    sudo systemctl stop keyd
    sudo rm -rf /usr/local/lib/systemd/system/keyd*
    sudo systemctl daemon-reload
fi

sudo rm -rf /etc/keyd
sudo rm -rf /usr/local/bin/keyd*
sudo rm -rf /usr/local/share/keyd
sudo rm -rf /usr/local/share/man/man1/keyd*
sudo rm -rf /usr/local/share/doc/keyd
sudo groupdel keyd
