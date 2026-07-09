echo "Setting up Claude Code..."

# Surgically merge CloudBees MCP env into ~/.claude/settings.json (creates the
# file if absent, touches only .env.CLOUDBEES_URL / .env.CLOUDBEES_TOKEN).
# The settings env block reaches MCP servers regardless of how the app is
# launched (Dock or terminal), unlike shell profile exports.
SETTINGS="$HOME/.claude/settings.json"
mkdir -p "$HOME/.claude"
[ -s "$SETTINGS" ] || echo '{}' > "$SETTINGS"

CLOUDBEES_URL="$(op read 'op://Dotfiles/Cloudbees MCP/url')"
CLOUDBEES_TOKEN="$(printf '%s:%s' "$(op read 'op://Dotfiles/Cloudbees MCP/username')" "$(op read 'op://Dotfiles/Cloudbees MCP/credential')" | base64 | tr -d '\n')"

jq --arg url "$CLOUDBEES_URL" --arg token "$CLOUDBEES_TOKEN" \
  '.env.CLOUDBEES_URL = $url | .env.CLOUDBEES_TOKEN = $token' \
  "$SETTINGS" > "$SETTINGS.tmp" && mv "$SETTINGS.tmp" "$SETTINGS"
