#!/bin/sh

# Inspired by https://medium.com/@battello.theo/fix-macos-forgetting-display-setup-using-displayplacer-and-shortcuts-17d1f1b11b36
# <xbar.title>Restore desk displays</xbar.title>
# <xbar.desc>Restores the preferred external-monitor and MacBook display layout.</xbar.desc>
# <xbar.dependencies>displayplacer</xbar.dependencies>

restore_command="$HOME/.local/bin/restore-desk-displays"

printf '| sfimage=display.2 tooltip=Restore-desk-display-layout\n'
printf '%s\n' '---'
printf 'Restore desk layout | bash=%s terminal=false\n' "$restore_command"
printf 'Inspect current state | bash=%s terminal=false\n' "$HOME/.local/bin/show-display-state"
