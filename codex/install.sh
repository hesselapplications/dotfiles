echo "Setting up Codex..."

# Codex cannot inject env into plugin-declared MCP servers from config.toml
# (openai/codex#24401), so fully redefine the cloudbees and launchdarkly servers
# with their env set literally — the documented workaround. The stable launchers
# resolve the versioned plugin cache when the MCP server starts, so plugin
# updates do not leave a stale path in this configuration.
CONFIG="$HOME/.codex/config.toml"
SCRIPT_DIR="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
LAUNCHER="$SCRIPT_DIR/cloudbees-mcp.sh"
LD_LAUNCHER="$SCRIPT_DIR/launchdarkly-mcp.sh"
mkdir -p "$HOME/.codex"
touch "$CONFIG"

for launcher in "$LAUNCHER" "$LD_LAUNCHER"; do
  if [ ! -f "$launcher" ]; then
    echo "MCP launcher not found at $launcher — skipping"
    exit 0
  fi
done

CLOUDBEES_URL="$(op read 'op://Dotfiles/Cloudbees MCP/url')"
CLOUDBEES_TOKEN="$(printf '%s:%s' "$(op read 'op://Dotfiles/Cloudbees MCP/username')" "$(op read 'op://Dotfiles/Cloudbees MCP/credential')" | base64 | tr -d '\n')"
LD_API_KEY="$(op read 'op://Dotfiles/Launch Darkly Api Token/credential')"

# Remove each server's two TOML tables by name rather than relying on comments.
# Codex can rewrite config.toml and previously left one of the marker comments
# behind, which prevented the old versioned path from being replaced safely.
TEMP_CONFIG="$(mktemp "$CONFIG.XXXXXX")"
trap 'rm -f "$TEMP_CONFIG"' EXIT
awk '
  /^[ \t]*\[mcp_servers\.(cloudbees|launchdarkly)(\.env)?\][ \t]*$/ { skipping = 1; next }
  skipping && /^[ \t]*\[/ { skipping = 0 }
  /^# >>> dotfiles cloudbees mcp >>>$/ { next }
  /^# <<< dotfiles cloudbees mcp <<</ { next }
  /^# >>> dotfiles launchdarkly mcp >>>$/ { next }
  /^# <<< dotfiles launchdarkly mcp <<</ { next }
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

cat >> "$CONFIG" <<EOF
# >>> dotfiles launchdarkly mcp >>>
[mcp_servers.launchdarkly]
command = "sh"
args = ["$LD_LAUNCHER"]

[mcp_servers.launchdarkly.env]
LD_API_KEY = "$LD_API_KEY"
# <<< dotfiles launchdarkly mcp <<<
EOF
