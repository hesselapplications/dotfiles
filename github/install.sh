echo "Setting up GitHub..."

mkdir -p "$OUTPUT_DIR/.config/gh"
op inject -i "github/config.yml.tpl" -o "$OUTPUT_DIR/.config/gh/config.yml"
op inject -i "github/hosts.yml.tpl" -o "$OUTPUT_DIR/.config/gh/hosts.yml"