# Get user choice
if [ $# -eq 0 ]; then
	SUB=$(gum choose "Theme" "Font" "Update" "Install" "Uninstall" "Manual" "Quit" --height 10 --header "" | tr '[:upper:]' '[:lower:]')
else
	SUB=$1
fi

# Handle choice
if [ -z "$SUB" ] || [ "$SUB" = "quit" ]; then # Use = for POSIX compliance inside []
  exit 0 # Exit the main script cleanly
else
  # Source the relevant script if it's not empty and not "quit"
  # Check if the sub-script file exists before sourcing
  SUB_SCRIPT="$OMAKUB_PATH/bin/omakub-sub/$SUB.sh"
  if [ -f "$SUB_SCRIPT" ]; then
      source "$SUB_SCRIPT"
  else
      echo "Error: Sub-script not found: $SUB_SCRIPT"
      # Optionally wait for user input or just loop back
      sleep 2
  fi
fi
