echo "Setting up Kubernetes..."

mkdir -p "$OUTPUT_DIR/.kube"
op read -o "$OUTPUT_DIR/.kube/config" "op://Dotfiles/Kube Config/config"