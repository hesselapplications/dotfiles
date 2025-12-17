# Docker compose aliases
alias composeup='prev_dir=$(pwd) && cd ~/Repos/ds1-configurations && docker compose up -d && cd "$prev_dir"'
alias composedown='prev_dir=$(pwd) && cd ~/Repos/ds1-configurations && docker compose down -v && cd "$prev_dir"'

# K6 load tests
export PASSWORD={{ op://Dotfiles/K6 Load Tests/credential }}
export K6_ENV=dev

# OpenAI
export OPENAI_API_KEY={{ op://Dotfiles/OpenAI/credential }}

# Google artifact registry
export GOOGLE_APPLICATION_CREDENTIALS=~/.config/gcloud/service-account-key.json

# Node version manager
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Docker
export PATH="$HOME/.docker/bin:$PATH"

# Pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - zsh)"

# Sdkman
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"