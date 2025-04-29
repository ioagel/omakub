# Run terminal installers
for installer in ~/.local/share/omakub/install/terminal/*.sh; do source $installer; done

if [[ "$DEFAULT_SHELL" == "zsh" ]]; then
    # Install and Setup ZSH
    source ~/.local/share/omakub/install/terminal/optional/zsh.sh
fi
