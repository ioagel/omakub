cd /tmp
# Download the AppImage using the API URL
DOWNLOAD_URL=$(curl -L "https://www.cursor.com/api/download?platform=linux-x64&releaseTrack=stable" | jq -r '.downloadUrl')
echo $DOWNLOAD_URL
if [ -z "$DOWNLOAD_URL" ] || [ "$DOWNLOAD_URL" == "null" ]; then
    echo "Error: Could not get download URL from Cursor API."
    exit 1
fi
echo "Downloading Cursor from $DOWNLOAD_URL..."
curl -L "$DOWNLOAD_URL" -o cursor.appimage
if [ ! -f cursor.appimage ]; then
    echo "Error: Failed to download cursor.appimage."
    exit 1
fi

# Make executable and extract
sudo chmod +x cursor.appimage
echo "Extracting AppImage..."
./cursor.appimage --appimage-extract > /dev/null # Suppress verbose output
if [ ! -d squashfs-root ]; then
    echo "Error: Failed to extract squashfs-root from AppImage."
    rm cursor.appimage # Clean up partial download
    exit 1
fi

# Move extracted contents to /opt
EXTRACTED_DIR="/opt/Cursor" # Define the target directory name
if [ -d "$EXTRACTED_DIR" ]; then
    echo "Removing existing installation at $EXTRACTED_DIR..."
    sudo rm -rf "$EXTRACTED_DIR"
fi
sudo mv squashfs-root "$EXTRACTED_DIR"
echo "AppImage extracted to $EXTRACTED_DIR"

# Clean up the downloaded AppImage file
rm cursor.appimage

# Ensure dependencies are installed
sudo apt update # Good practice to update before install
sudo apt install -y fuse3 libfuse2t64 # Keep fuse dependencies just in case parts still need it

# --- Create Desktop File ---
DESKTOP_FILE="$HOME/.local/share/applications/cursor.desktop"
APP_EXEC="$EXTRACTED_DIR/AppRun" # Assuming AppRun is the main executable
APP_ICON="$HOME/.local/share/omakub/applications/icons/cursor.png" # Keep original icon path

# Check if the assumed executable exists
if [ ! -f "$APP_EXEC" ]; then
    echo "Warning: Assumed executable '$APP_EXEC' not found. Trying '$EXTRACTED_DIR/cursor'..."
    APP_EXEC="$EXTRACTED_DIR/cursor" # Fallback to 'cursor' executable name
    if [ ! -f "$APP_EXEC" ]; then
       echo "Error: Neither '$EXTRACTED_DIR/AppRun' nor '$EXTRACTED_DIR/cursor' found."
       echo "Cannot create .desktop file. Please check the contents of $EXTRACTED_DIR manually."
       exit 1
    fi
fi


echo "Creating desktop file $DESKTOP_FILE..."
sudo bash -c "cat > $DESKTOP_FILE" <<EOL
[Desktop Entry]
Name=Cursor
Comment=AI-powered code editor
Exec=$APP_EXEC --no-sandbox
Icon=$APP_ICON
Type=Application
Categories=Development;IDE;
EOL

# Verify creation
if [ -f "$DESKTOP_FILE" ]; then
    echo "cursor.desktop created successfully pointing to $APP_EXEC"
else
    echo "Error: Failed to create cursor.desktop"
    exit 1 # Exit with error if desktop file fails
fi

echo "Cursor installation complete."
