echo "Setting up Git..."

mkdir -p "$OUTPUT_DIR"
op inject -i "git/.gitconfig.tpl" -o "$OUTPUT_DIR/.gitconfig"
