if [[ "$(uname)" == "Darwin" ]]; then
  # macOS — requires Homebrew (https://brew.sh)
  brew install ripgrep unzip python3 node
  curl https://sh.rustup.rs -sSf | sh -s -- -y

  # nvim pinned to v0.10.4 — plugins are pinned to 0.10-compatible versions
  if [[ "$(uname -m)" == "arm64" ]]; then
    NVIM_PKG=nvim-macos-arm64
  else
    NVIM_PKG=nvim-macos-x86_64
  fi
  sudo rm -rf /opt/nvim
  rm -rf "$NVIM_PKG.tar.gz"
  curl -LO "https://github.com/neovim/neovim/releases/download/v0.10.4/$NVIM_PKG.tar.gz"
  xattr -c "$NVIM_PKG.tar.gz"
  tar -xzf "$NVIM_PKG.tar.gz" && sudo mv "$NVIM_PKG" /opt/nvim && rm -rf "$NVIM_PKG.tar.gz"
else
  # Linux
  sudo curl https://sh.rustup.rs -sSf | sh -s -- -y
  sudo apt-get install -y ripgrep
  sudo apt-get install -y unzip
  sudo apt install -y python3-pip
  sudo apt install -y python3-venv
  sudo apt install -y ipython3
  sudo apt install -y npm

  # nvim pinned to v0.10.4 — plugins are pinned to 0.10-compatible versions
  sudo rm -rf /opt/nvim
  sudo rm -rf nvim-linux-x86_64.tar.gz
  sudo curl -LO https://github.com/neovim/neovim/releases/download/v0.10.4/nvim-linux-x86_64.tar.gz && sudo tar -xzf nvim-linux-x86_64.tar.gz && sudo mv nvim-linux-x86_64 /opt/nvim && sudo rm -rf nvim-linux-x86_64.tar.gz
fi

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

tmux kill-server
tmux start-server
