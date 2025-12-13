echo "Setting up Node.js..."

NVM_VERSION="0.40.3"
NODE_VERSION="22.19.0"

if [ -s "$HOME/.nvm/nvm.sh" ]; then
  source "$HOME/.nvm/nvm.sh"
else
  echo "Installing nvm..."
  curl -o- "https://raw.githubusercontent.com/nvm-sh/nvm/v$NVM_VERSION/install.sh" | bash
  source "$HOME/.nvm/nvm.sh"
  echo "Installed nvm: $(nvm --version)"
fi

if nvm current | grep -q "$NODE_VERSION"; then
  echo "Using node version $(nvm current)"
else
  echo "Installing node..."
  source "$HOME/.nvm/nvm.sh" &> /dev/null
  nvm use "$NODE_VERSION" &> /dev/null
  nvm install "$NODE_VERSION" &> /dev/null
  nvm alias default "$NODE_VERSION" &> /dev/null
  nvm use "$NODE_VERSION" &> /dev/null
  echo "Using node version $(nvm current)"
fi

mkdir -p "$OUTPUT_DIR"
op read -o "$OUTPUT_DIR/.npmrc" "op://Dotfiles/NPM RC/.npmrc"
