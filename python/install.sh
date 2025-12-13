echo "Setting up Python..."

PYTHON_VERSION="3.13.5"

if pyenv version | grep -q "$PYTHON_VERSION"; then
  echo "Using python version $(pyenv version)"
else
  echo "Installing Python..."
  pyenv global "$PYTHON_VERSION" &> /dev/null
  pyenv install "$PYTHON_VERSION" --skip-existing &> /dev/null
  pyenv global "$PYTHON_VERSION" &> /dev/null
  echo "Using python version $(pyenv version)"
fi
