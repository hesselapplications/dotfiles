echo "Setting up Codex..."

# Codex cannot inject env into plugin-declared MCP servers from config.toml
# (openai/codex#24401), so fully redefine the cloudbees server with its env set
# literally — the documented workaround. The stable launcher resolves the
# versioned plugin cache when the MCP server starts, so plugin updates do not
# leave a stale path in this configuration.
CONFIG="$HOME/.codex/config.toml"
SCRIPT_DIR="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
LAUNCHER="$SCRIPT_DIR/cloudbees-mcp.sh"
mkdir -p "$HOME/.codex"
touch "$CONFIG"

if [ ! -f "$LAUNCHER" ]; then
  echo "CloudBees MCP launcher not found at $LAUNCHER — skipping"
  exit 0
fi

CLOUDBEES_URL="$(op read 'op://Dotfiles/Cloudbees MCP/url')"
CLOUDBEES_TOKEN="$(printf '%s:%s' "$(op read 'op://Dotfiles/Cloudbees MCP/username')" "$(op read 'op://Dotfiles/Cloudbees MCP/credential')" | base64 | tr -d '\n')"

# Remove CloudBees' two TOML tables by name rather than relying on comments.
# Codex can rewrite config.toml and previously left one of the marker comments
# behind, which prevented the old versioned path from being replaced safely.
TEMP_CONFIG="$(mktemp "$CONFIG.XXXXXX")"
trap 'rm -f "$TEMP_CONFIG"' EXIT
awk '
  /^\[mcp_servers\.cloudbees(\.env)?\]$/ { skipping = 1; next }
  skipping && /^\[/ { skipping = 0 }
  /^# >>> dotfiles cloudbees mcp >>>$/ { next }
  /^# <<< dotfiles cloudbees mcp <<</ { next }
  !skipping { print }
' "$CONFIG" > "$TEMP_CONFIG"
mv "$TEMP_CONFIG" "$CONFIG"
trap - EXIT

cat >> "$CONFIG" <<EOF
# >>> dotfiles cloudbees mcp >>>
[mcp_servers.cloudbees]
command = "sh"
args = ["$LAUNCHER"]

[mcp_servers.cloudbees.env]
CLOUDBEES_URL = "$CLOUDBEES_URL"
CLOUDBEES_TOKEN = "$CLOUDBEES_TOKEN"
# <<< dotfiles cloudbees mcp <<<
EOF
