cd /tmp

# API endpoint for JetBrains product releases
API_URL="https://data.services.jetbrains.com/products/releases?code=TBA&latest=true&type=release"

echo "Querying JetBrains release API..."

# Fetch data, extract build number and download link for Linux
JSON_DATA=$(curl -sL "$API_URL")

# Check if curl succeeded and got some data
if [ -z "$JSON_DATA" ]; then
    echo "Error: Failed to fetch data from API_URL."
    exit 1
fi

# Extract Build Number (using printf to pipe variable content)
BUILD_NUMBER=$(printf '%s' "$JSON_DATA" | jq -r '.TBA[0].build')

# Extract Linux Download URL (using printf)
DOWNLOAD_URL=$(printf '%s' "$JSON_DATA" | jq -r '.TBA[0].downloads.linux.link')
CHECKSUM_URL=$(printf '%s' "$JSON_DATA" | jq -r '.TBA[0].downloads.linux.checksumLink') # Optional: Get checksum link too

# --- Validation ---
if [ -z "$BUILD_NUMBER" ] || [ "$BUILD_NUMBER" == "null" ]; then
  echo "Error: Could not extract build number from API response."
  # echo "Response was:" # Maybe don't print the whole response if it has control chars
  exit 1
fi

if [ -z "$DOWNLOAD_URL" ] || [ "$DOWNLOAD_URL" == "null" ]; then
  echo "Error: Could not extract Linux download URL from API response."
  # echo "Response was:"
  exit 1
fi

echo "Found Build Number: $BUILD_NUMBER"
echo "Found Download URL: $DOWNLOAD_URL"

# --- Download ---
FILENAME="jetbrains-toolbox-${BUILD_NUMBER}.tar.gz" # Construct filename based on build number
echo "Downloading $FILENAME..."
curl -L -o "$FILENAME" "$DOWNLOAD_URL"

# --- Verification ---
if [ -f "$FILENAME" ]; then
  echo "Download successful: $FILENAME"
  # Optional: Download checksum and verify
  if [ -n "$CHECKSUM_URL" ] && [ "$CHECKSUM_URL" != "null" ]; then
    echo "Downloading checksum..."
    curl -L -o "${FILENAME}.sha256" "$CHECKSUM_URL"
    echo "Verifying checksum..."
    # Check if checksum file downloaded successfully before verifying
    if [ -f "${FILENAME}.sha256" ]; then
        sha256sum -c "${FILENAME}.sha256"
    else
        echo "Warning: Failed to download checksum file."
    fi
  fi
  echo "Extracting..."
  mkdir -p /tmp/jetbrains-Toolbox
  tar -xzf "$FILENAME" -C /tmp/jetbrains-Toolbox --strip-components=1
  # run the app
  /tmp/jetbrains-Toolbox/jetbrains-toolbox
  sleep 5
  killall jetbrains-toolbox
else
  echo "Error: Download failed."
  exit 1
fi

echo "JetBrains Toolbox download and verification complete."