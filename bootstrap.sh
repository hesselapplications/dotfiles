set -o nounset  # Treat unset variables as an error
set -o errexit  # Exit immediately if a command exits with a non-zero status
set -o pipefail # Prevent errors in a pipeline from being masked

export OUTPUT_DIR="$HOME"
#export OUTPUT_DIR=".output" # Uncomment for testing

# Install Homebrew if not installed
if ! command -v brew &> /dev/null; then
  echo "Homebrew not found. Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
  echo "Homebrew is already installed. Skipping installation."
fi

# Setup Homebrew environment
echo "Setting up Homebrew environment..."
echo >> "$OUTPUT_DIR/.zprofile"
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> "$OUTPUT_DIR/.zprofile"
eval "$(/opt/homebrew/bin/brew shellenv)"
brew analytics off
echo "Homebrew environment setup complete."

echo "Cloning dotfiles repository..."
brew install git
REPO_DIR="$HOME/Repos/dotfiles"
rm -rf "$REPO_DIR"
mkdir -p "$REPO_DIR"
git clone --quiet https://github.com/hesselapplications/dotfiles.git "$REPO_DIR"
cd "$REPO_DIR"
echo "Dotfiles repository cloned."

# Run Brewfile
echo "Running Brewfile with brew bundle..."
brew bundle --file="$REPO_DIR/Brewfile" || echo "Continuing..."
echo "Brewfile installation complete."

# Sign into 1Password
if ! op account list | grep -q "EMAIL"; then
  echo "Enable 1Password CLI access then rerun the bootstrap script."
  open "https://developer.1password.com/docs/cli/app-integration/"
  open -a "1Password"
  exit 1
fi

# Find and run all install scripts
echo "Running all install.sh scripts..."
find "$REPO_DIR" -name install.sh -exec chmod +x {} \;
find "$REPO_DIR" -name install.sh | sort | while read -r installer ; do sh -c "${installer}" ; done
echo "Finished running all install.sh scripts."

echo "Bootstrap process complete :)"
unset OUTPUT_DIR