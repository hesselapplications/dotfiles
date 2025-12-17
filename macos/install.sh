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

echo "MacOS setup complete."