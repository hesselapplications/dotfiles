echo "Setting up Chrome..."

BROWSER_EXTENSIONS_DIR="$HOME/Documents/Repos/browser-extensions"
git clone git@github.com:MerrillCorporation/browser-extensions.git "$BROWSER_EXTENSIONS_DIR"
killall "Google Chrome" &> /dev/null || echo "Chrome not running."
open -a "Google Chrome" --args \
  --silent-launch \
  --no-first-run \
  --make-default-browser \
  --load-extension="$BROWSER_EXTENSIONS_DIR/swagger-registry" \
  --load-extension="$BROWSER_EXTENSIONS_DIR/swagger-auto-auth" \
  --load-extension="$BROWSER_EXTENSIONS_DIR/github-squad-search"

echo "Chrome setup complete. Remember to configure the auto-auth extension!"