#!/bin/sh

# Resolve the installed Datasite plugin's LaunchDarkly command at MCP-server
# startup, so plugin updates to the pinned server version or tool list apply
# without re-running the installer. LD_API_KEY comes from config.toml's env.
PLUGIN_CACHE="$HOME/.codex/plugins/cache"
MCP_JSON="$(find "$PLUGIN_CACHE" -type f -path '*/.codex-plugin/mcp.json' -print 2>/dev/null | sort -V | xargs grep -l '"launchdarkly"' 2>/dev/null | tail -n 1)"

if [ -z "$MCP_JSON" ]; then
  echo "LaunchDarkly MCP definition not found under $PLUGIN_CACHE" >&2
  exit 1
fi

COMMAND="$(jq -r '(.mcpServers // .).launchdarkly.args[-1]' "$MCP_JSON")"
exec sh -c "$COMMAND"
