echo "Setting up GCloud..."

mkdir -p "$OUTPUT_DIR/.config/gcloud"
op read -o "$OUTPUT_DIR/.config/gcloud/service-account-key.json" "op://Dotfiles/Google Application Credentials/service-account-key.json"

gcloud components install gke-gcloud-auth-plugin

echo "GCloud setup complete."