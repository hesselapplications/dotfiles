echo "Setting up Zsh..."

mkdir -p "$OUTPUT_DIR"
op inject -f -i "zsh/.zshrc.tpl" -o "$OUTPUT_DIR/.zshrc"