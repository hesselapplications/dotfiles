echo "Setting up SSH..."

mkdir -p "$OUTPUT_DIR/.ssh"
op inject -i "ssh/config.tpl" -o "$OUTPUT_DIR/.ssh/config"
op read -o "$OUTPUT_DIR/.ssh/id_ed25519" "op://Dotfiles/Github SSH/private key"
op read -o "$OUTPUT_DIR/.ssh/id_ed25519.pub" "op://Dotfiles/Github SSH/public key"