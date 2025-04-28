cat <<EOF >~/.local/share/applications/Omakub.desktop
[Desktop Entry]
Version=1.0
Name=Omakub
Comment=Omakub Controls
Exec=alacritty --config-file $HOME/.config/alacritty/pane.toml --class=Omakub --title=Omakub -e bash -c "export OMAKUB_PATH=$HOME/.local/share/omakub; cd $OMAKUB_PATH/bin/ && ./omakub"
Terminal=false
Type=Application
Icon=$HOME/.local/share/omakub/applications/icons/Omakub.png
Categories=GTK;
StartupNotify=false
EOF
