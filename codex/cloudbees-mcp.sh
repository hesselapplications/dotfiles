#!/bin/sh

# Resolve the installed Datasite plugin at MCP-server startup. Plugin caches are
# versioned and old versions may be removed during an update, so this wrapper
# deliberately avoids embedding a versioned path in Codex's configuration.
PLUGIN_CACHE="$HOME/.codex/plugins/cache"
SERVER_DIR="$(find "$PLUGIN_CACHE" -type d -path '*/mcp-servers/cloudbees' -print 2>/dev/null | sort -V | tail -n 1)"

if [ -z "$SERVER_DIR" ] || [ ! -f "$SERVER_DIR/src/mcp_server.py" ]; then
  echo "CloudBees MCP server not found under $PLUGIN_CACHE" >&2
  exit 1
fi

exec uv run --directory "$SERVER_DIR" --no-cache src/mcp_server.py
