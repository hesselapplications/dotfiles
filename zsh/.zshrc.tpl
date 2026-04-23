# Uncomment both zprof lines to diagnose shell startup performance
# zmodload zsh/zprof

# Docker compose aliases
alias composeup='prev_dir=$(pwd) && cd ~/Repos/ds1-configurations && docker compose up -d && cd "$prev_dir"'
alias composedown='prev_dir=$(pwd) && cd ~/Repos/ds1-configurations && docker compose down && docker volume ls -q --filter dangling=true | grep -v sourcebot | xargs -r docker volume rm > /dev/null; cd "$prev_dir"'

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

# SDKMAN — add candidate shims to PATH directly (skip ~1s init), lazy-load `sdk` on first use
export SDKMAN_DIR="$HOME/.sdkman"
export JAVA_HOME="$SDKMAN_DIR/candidates/java/current"
export KOTLIN_HOME="$SDKMAN_DIR/candidates/kotlin/current"
export GRADLE_HOME="$SDKMAN_DIR/candidates/gradle/current"
export PATH="$JAVA_HOME/bin:$KOTLIN_HOME/bin:$GRADLE_HOME/bin:$PATH"
sdk() {
  unset -f sdk
  [[ -s "$SDKMAN_DIR/bin/sdkman-init.sh" ]] && source "$SDKMAN_DIR/bin/sdkman-init.sh"
  sdk "$@"
}

# zprof