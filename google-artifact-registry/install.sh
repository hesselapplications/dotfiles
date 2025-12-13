echo "Setting up Google Artifact Registry..."

mkdir -p "$OUTPUT_DIR/.config/gcloud"
op read -o "$OUTPUT_DIR/.config/gcloud/service-account-key.json" "op://Dotfiles/Google Application Credentials/service-account-key.json"