# Docker compose aliases
alias composeup='prev_dir=$(pwd) && cd ~/Repos/ds1-configurations && docker compose up -d && cd "$prev_dir"'
alias composedown='prev_dir=$(pwd) && cd ~/Repos/ds1-configurations && docker compose down -v && cd "$prev_dir"'

# Google artifact registry
export GOOGLE_APPLICATION_CREDENTIALS=~/.config/gcloud/service-account-key.json

# Node version manager (lazy — defer 400ms load until first use)
export NVM_DIR="$HOME/.nvm"
_load_nvm() {
  unset -f nvm node npm npx yarn pnpm
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
}
for _cmd in nvm node npm npx yarn pnpm; do
  eval "${_cmd}() { _load_nvm; ${_cmd} \"\$@\"; }"
done
unset _cmd

# Cursor
PATH="$HOME/.local/bin:$PATH"

# Docker
export PATH="$HOME/.docker/bin:$PATH"

# Pyenv — set up shims directly (skip 100ms subprocess init)
export PYENV_ROOT="$HOME/.pyenv"
export PYENV_SHELL=zsh
export PATH="$PYENV_ROOT/shims:$PYENV_ROOT/bin:$PATH"

# Lazy-load the full pyenv function (needed only for `pyenv shell` / `pyenv rehash` / completions)
pyenv() {
  unset -f pyenv
  eval "$(command pyenv init - zsh)"
  pyenv "$@"
}

# Sdkman
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"