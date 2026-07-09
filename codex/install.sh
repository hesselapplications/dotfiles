echo "Setting up Codex..."

# Codex cannot inject env into plugin-declared MCP servers from config.toml
# (openai/codex#24401), so fully redefine the cloudbees server with its env set
# literally — the documented workaround. The block below is marker-delimited and
# regenerated on every run; nothing outside the markers is touched.
# Re-run this script after a plugin version bump.
CONFIG="$HOME/.codex/config.toml"
mkdir -p "$HOME/.codex"
touch "$CONFIG"

SERVER_DIR="$(ls -d "$HOME/.codex/plugins/cache"/*/*/*/mcp-servers/cloudbees 2>/dev/null | sort -V | tail -1)"
if [ -z "$SERVER_DIR" ]; then
  echo "no cloudbees MCP server found under ~/.codex/plugins/cache — skipping"
  exit 0
fi

CLOUDBEES_URL="$(op read 'op://Dotfiles/Cloudbees MCP/url')"
CLOUDBEES_TOKEN="$(printf '%s:%s' "$(op read 'op://Dotfiles/Cloudbees MCP/username')" "$(op read 'op://Dotfiles/Cloudbees MCP/credential')" | base64 | tr -d '\n')"

sed -i '' '/^# >>> dotfiles cloudbees mcp >>>$/,/^# <<< dotfiles cloudbees mcp <<<$/d' "$CONFIG"

cat >> "$CONFIG" <<EOF
# >>> dotfiles cloudbees mcp >>>
[mcp_servers.cloudbees]
command = "uv"
args = ["run", "--directory", "$SERVER_DIR", "--no-cache", "src/mcp_server.py"]

[mcp_servers.cloudbees.env]
CLOUDBEES_URL = "$CLOUDBEES_URL"
CLOUDBEES_TOKEN = "$CLOUDBEES_TOKEN"
# <<< dotfiles cloudbees mcp <<<
EOF
