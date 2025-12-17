# Dotfiles
My dotfiles for configuring apps and tools on my system.

# Usage
Set up machine by running:
```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/hesselapplications/dotfiles/master/bootstrap.sh)"
```

Afterwards, do the following:
- [Chrome sync](https://support.google.com/chrome/answer/185277?hl=en&co=GENIE.Platform%3DDesktop#)
- [VSCode sync](https://code.visualstudio.com/docs/configure/settings-sync)
- [IntelliJ sync](https://www.jetbrains.com/help/idea/sharing-your-ide-settings.html)
- [iCloud sync](https://support.apple.com/guide/mac-help/set-up-icloud-mh36834/mac)
- [Sign in to iCloud](https://support.apple.com/en-us/102314) to sync messages, contacts, notes, reminders and passwords
- [Sign in to Google](https://support.apple.com/guide/mac-help/add-your-email-and-other-accounts-mh35565/mac) to sync contacts

# 1Password
Secrets are managed using 1Password CLI
- https://developer.1password.com/docs/cli/get-started/
- https://developer.1password.com/docs/ssh/agent/

# TODO
- Enable touch ID for sudo
- Allow screen & system audio recording
  - Chrome
  - Loom
  - Microsoft Teams
  - Slack
  - Zoom
- Sign into VPN
- Finder
  - Show path bar in finder
  - Add user home directories to favorites
  - Show hidden files
- Settings
  - Screen never sleep when plugged in
  - Disable mouse natural scrolling
- Clone ds1-configurations
  - Create docker-compose.yml
  - Create application-local.yml
- Set wallpaper
- Finder view options > sort by "Snap to grid"
- Move desktop dock to right side
- Set keyboard shortcuts
  - ctrl -> command key mapping