# Install keyd, a key remapping daemon
# Remap capslock to escape when pressed and control when held.
# Remap escape to capslock.

cd /tmp

# Remove keyd if it exists
rm -rf keyd

git clone https://github.com/rvaiya/keyd
cd keyd
make
sudo make install

echo "Creating keyd config..."
sudo bash -c "cat > /etc/keyd/default.conf" <<EOL
[ids]

*

[main]

# Maps capslock to escape when pressed and control when held.
capslock = overload(control, esc)

# Remaps the escape key to capslock
esc = capslock
EOL

sudo systemctl enable keyd
sudo systemctl start keyd
