echo "Setting up Chrome..."
open -a "Google Chrome" --args --make-default-browser

BROWSER_EXTENSIONS_DIR="$HOME/Documents/Repos/browser-extensions"
git clone git@github.com:MerrillCorporation/browser-extensions.git "$BROWSER_EXTENSIONS_DIR"
open -a "Google Chrome" --args --load-extension="$BROWSER_EXTENSIONS_DIR/swagger-registry"
open -a "Google Chrome" --args --load-extension="$BROWSER_EXTENSIONS_DIR/swagger-auto-auth"
open -a "Google Chrome" --args --load-extension="$BROWSER_EXTENSIONS_DIR/github-squad-search"

echo "Chrome setup complete. Remember to configure the auto-auth extension!"