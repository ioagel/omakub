# Install zsh
command -v zsh >/dev/null || sudo apt install -y zsh

export ZSH="$HOME/.oh-my-zsh"
export ZSH_CUSTOM="$ZSH/custom"

# Install oh-my-zsh
if [ ! -d "$ZSH" ]; then
  git clone https://github.com/ohmyzsh/ohmyzsh.git "$ZSH"
else
  git -C "$ZSH" pull
fi
# check if a .zshrc exists and is not a symbolic link
[ -f ~/.zshrc ] && [ ! -L ~/.zshrc ] && mv ~/.zshrc ~/.zshrc.bak
# Prefer links
ln -sf "$OMAKUB_PATH"/defaults/zsh/zshrc ~/.zshrc

# Install zsh-autosuggestions
if [ ! -d "$ZSH_CUSTOM"/plugins/zsh-autosuggestions ]; then
  git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM"/plugins/zsh-autosuggestions
else
  git -C "$ZSH_CUSTOM"/plugins/zsh-autosuggestions pull
fi

# Install zsh-syntax-highlighting
if [ ! -d "$ZSH_CUSTOM"/plugins/zsh-syntax-highlighting ]; then
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_CUSTOM"/plugins/zsh-syntax-highlighting
else
  git -C "$ZSH_CUSTOM"/plugins/zsh-syntax-highlighting pull
fi

# Install starship
mkdir -p ~/.local/bin
command -v starship >/dev/null || curl -fsSL https://starship.rs/install.sh | sh -s -- -y -b ~/.local/bin

# Make zsh the default shell
sudo chsh -s "$(which zsh)" "$USER"

echo "Logout and log back in for changes to take effect."

sleep 3
