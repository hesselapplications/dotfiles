echo "Setting up Chrome..."

BROWSER_EXTENSIONS_DIR="$HOME/Documents/Repos/browser-extensions"
rm -rf "$BROWSER_EXTENSIONS_DIR"
mkdir -p "$BROWSER_EXTENSIONS_DIR"
git clone git@github.com:MerrillCorporation/browser-extensions.git "$BROWSER_EXTENSIONS_DIR"

https://peter.sh/experiments/chromium-command-line-switches/
open -a "Google Chrome" --args --make-default-browser

echo "Chrome setup complete. Remember to load & configure custom extensions!"