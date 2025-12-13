echo "Setting up VSCode..."

mkdir -p "$OUTPUT_DIR/.vscode/extensions"
op inject -i "vscode/extensions.json.tpl" -o "$OUTPUT_DIR/.vscode/extensions/extensions.json"