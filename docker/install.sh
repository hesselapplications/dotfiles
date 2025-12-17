echo "Setting up Docker..."

mkdir -p "$OUTPUT_DIR/docker"
op inject -i "docker/.config.json.tpl" -o "$OUTPUT_DIR/docker/.config.json"

echo "Docker setup complete."
