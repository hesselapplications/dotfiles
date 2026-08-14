echo "Setting up MacOS..."

# https://www.defaults-write.com/
# https://github.com/mathiasbynens/dotfiles/blob/main/.macos

# Close any open System Preferences panes, to prevent them from overriding settings we’re about to change
osascript -e 'tell application "System Preferences" to quit'

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until `.macos` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Finder
defaults write NSGlobalDomain AppleShowAllExtensions -bool true             # Show all file extensions
defaults write com.apple.finder AppleShowAllFiles -boolean true             # Show hidden files
defaults write com.apple.finder ShowPathbar -boolean true                   # Show path bar
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"         # List view by default
defaults write com.apple.finder _FXSortFoldersFirst -boolean true           # Folders on top when sorting by name
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"         # Search current folder by default
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false  # Disable extension change warning
killall Finder

# Screen Captures
mkdir -p "$HOME/Documents/Screenshots"
defaults write com.apple.screencapture location -string "$HOME/Documents/Screenshots" # Save location
defaults write com.apple.screencapture type -string "png" # Save format
defaults write com.apple.screencapture disable-shadow -bool true # Disable shadow

# Display layout
script_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
mkdir -p "$OUTPUT_DIR/.local/bin"
restore_displays_tmp=$(mktemp "$OUTPUT_DIR/.local/bin/.restore-desk-displays.XXXXXX")
install -m 755 "$script_dir/restore-desk-displays" "$restore_displays_tmp"
mv -f "$restore_displays_tmp" "$OUTPUT_DIR/.local/bin/restore-desk-displays"
show_display_state_tmp=$(mktemp "$OUTPUT_DIR/.local/bin/.show-display-state.XXXXXX")
install -m 755 "$script_dir/show-display-state" "$show_display_state_tmp"
mv -f "$show_display_state_tmp" "$OUTPUT_DIR/.local/bin/show-display-state"

# SwiftBar menu-bar control for the display layout
swiftbar_plugin_dir="$OUTPUT_DIR/.swiftbar"
swiftbar_plugin_path="$swiftbar_plugin_dir/restore-desk-displays.1d.sh"
mkdir -p "$swiftbar_plugin_dir"
swiftbar_plugin_tmp=$(mktemp "$swiftbar_plugin_dir/.restore-desk-displays.XXXXXX")
install -m 755 "$(dirname "$script_dir")/swiftbar/restore-desk-displays.1d.sh" "$swiftbar_plugin_tmp"
mv -f "$swiftbar_plugin_tmp" "$swiftbar_plugin_path"
defaults write com.ameba.SwiftBar PluginDirectory -string "$OUTPUT_DIR/.swiftbar"

echo "MacOS setup complete."
