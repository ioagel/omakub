sudo apt purge -y zsh
sudo apt autoremove --purge -y
rm -rf ~/.oh-my-zsh
rm -rf ~/.zshrc
rm -rf ~/.local/bin/starship
sudo chsh -s /bin/bash "$USER"
