echo "Setting up Bash..."

mkdir -p "$OUTPUT_DIR"
op inject -i "bash/.bash_profile.tpl" -o "$OUTPUT_DIR/.bash_profile"