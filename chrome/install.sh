echo "Setting up Chrome..."
open -a "Google Chrome" --args --make-default-browser --silent-launch

BROWSER_EXTENSIONS_DIR="$HOME/Documents/Repos/browser-extensions"
git clone git@github.com:MerrillCorporation/browser-extensions.git "$BROWSER_EXTENSIONS_DIR"
open -a "Google Chrome" --args --load-extension="$BROWSER_EXTENSIONS_DIR/swagger-registry" --silent-launch
open -a "Google Chrome" --args --load-extension="$BROWSER_EXTENSIONS_DIR/swagger-auto-auth" --silent-launch
open -a "Google Chrome" --args --load-extension="$BROWSER_EXTENSIONS_DIR/github-squad-search" --silent-launch

echo "Chrome setup complete. Remember to configure the auto-auth extension!"