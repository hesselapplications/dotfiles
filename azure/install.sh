echo "Setting up Azure..."

mkdir -p "$OUTPUT_DIR/.azure"
op read -o "$OUTPUT_DIR/.azure/config" "op://Dotfiles/Azure Config/config"
op read -o "$OUTPUT_DIR/.azure/clouds.config" "op://Dotfiles/Azure Clouds Config/clouds.config"
op read -o "$OUTPUT_DIR/.azure/azureProfile.json" "op://Dotfiles/Azure Profile/azureProfile.json"