NVIM_VERSION=v0.12.5
TMUX_VERSION=3.4
TREE_SITTER_VERSION=v0.27.0

if [[ "$(uname)" == "Darwin" ]]; then
  # macOS — requires Homebrew (https://brew.sh)
  brew install ripgrep unzip python3 node stow go
  curl https://sh.rustup.rs -sSf | sh -s -- -y

  # nvim pinned to $NVIM_VERSION — source tarball, same as Linux (no plugin pinning needed anymore)
  if [[ "$(uname -m)" == "arm64" ]]; then
    NVIM_PKG=nvim-macos-arm64
    TS_PKG=tree-sitter-cli-macos-arm64
  else
    NVIM_PKG=nvim-macos-x86_64
    TS_PKG=tree-sitter-cli-macos-x64
  fi
  sudo rm -rf /opt/nvim
  rm -rf "$NVIM_PKG.tar.gz"
  curl -LO "https://github.com/neovim/neovim/releases/download/$NVIM_VERSION/$NVIM_PKG.tar.gz"
  xattr -c "$NVIM_PKG.tar.gz"
  tar -xzf "$NVIM_PKG.tar.gz" && sudo mv "$NVIM_PKG" /opt/nvim && rm -rf "$NVIM_PKG.tar.gz"

  # tmux pinned to $TMUX_VERSION, built from source — Homebrew only ever tracks
  # latest (no versioned formula), so this is the only way to pin it here.
  # --enable-utf8proc is required on macOS (configure refuses to guess).
  brew install libevent ncurses pkg-config utf8proc
  sudo rm -rf /opt/tmux
  rm -rf "tmux-$TMUX_VERSION" "tmux-$TMUX_VERSION.tar.gz"
  curl -LO "https://github.com/tmux/tmux/releases/download/$TMUX_VERSION/tmux-$TMUX_VERSION.tar.gz"
  tar -xzf "tmux-$TMUX_VERSION.tar.gz"
  (cd "tmux-$TMUX_VERSION" && ./configure --prefix=/opt/tmux --with-TERM=screen-256color --enable-utf8proc && make && sudo make install)
  rm -rf "tmux-$TMUX_VERSION" "tmux-$TMUX_VERSION.tar.gz"

  # tree-sitter-cli, required by nvim-treesitter's `main` branch (>=0.26.1) to
  # build parsers. Precompiled binary — apt/npm versions lag too far behind.
  sudo rm -rf /opt/tree-sitter
  rm -rf "$TS_PKG.zip"
  curl -LO "https://github.com/tree-sitter/tree-sitter/releases/download/$TREE_SITTER_VERSION/$TS_PKG.zip"
  sudo mkdir -p /opt/tree-sitter/bin
  sudo unzip -o "$TS_PKG.zip" -d /opt/tree-sitter/bin
  rm -rf "$TS_PKG.zip"
else
  # Linux
  sudo curl https://sh.rustup.rs -sSf | sh -s -- -y
  sudo apt-get install -y ripgrep
  sudo apt-get install -y unzip
  sudo apt install -y python3-pip
  sudo apt install -y python3-venv
  sudo apt install -y ipython3
  sudo apt install -y npm
  sudo apt-get install -y stow
  sudo apt-get install -y golang-go

  # nvim pinned to $NVIM_VERSION — source tarball, same as macOS
  sudo rm -rf /opt/nvim
  sudo rm -rf nvim-linux-x86_64.tar.gz
  sudo curl -LO "https://github.com/neovim/neovim/releases/download/$NVIM_VERSION/nvim-linux-x86_64.tar.gz" && sudo tar -xzf nvim-linux-x86_64.tar.gz && sudo mv nvim-linux-x86_64 /opt/nvim && sudo rm -rf nvim-linux-x86_64.tar.gz

  # tmux pinned to $TMUX_VERSION, built from source — apt is capped at whatever
  # Ubuntu's LTS release froze (3.4 here already, but this keeps the install
  # mechanism identical to macOS instead of "apt here, compile there").
  sudo apt-get install -y build-essential pkg-config bison libevent-dev libncurses-dev
  sudo rm -rf /opt/tmux
  rm -rf "tmux-$TMUX_VERSION" "tmux-$TMUX_VERSION.tar.gz"
  curl -LO "https://github.com/tmux/tmux/releases/download/$TMUX_VERSION/tmux-$TMUX_VERSION.tar.gz"
  tar -xzf "tmux-$TMUX_VERSION.tar.gz"
  (cd "tmux-$TMUX_VERSION" && ./configure --prefix=/opt/tmux && make && sudo make install)
  rm -rf "tmux-$TMUX_VERSION" "tmux-$TMUX_VERSION.tar.gz"

  # tree-sitter-cli, required by nvim-treesitter's `main` branch (>=0.26.1) to
  # build parsers. apt only has 0.20.8 on Ubuntu 24.04 — too old. Precompiled
  # binary, same as nvim, rather than a slow/fragile cargo build.
  sudo rm -rf /opt/tree-sitter
  rm -rf tree-sitter-cli-linux-x64.zip
  curl -LO "https://github.com/tree-sitter/tree-sitter/releases/download/$TREE_SITTER_VERSION/tree-sitter-cli-linux-x64.zip"
  sudo mkdir -p /opt/tree-sitter/bin
  sudo unzip -o tree-sitter-cli-linux-x64.zip -d /opt/tree-sitter/bin
  rm -rf tree-sitter-cli-linux-x64.zip
fi

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# make the tools just installed available to the rest of this script run,
# without waiting on a new shell / re-sourcing .bashrc
export PATH="$PATH:/opt/nvim/bin:/opt/tmux/bin:/opt/tree-sitter/bin"

tmux kill-server
tmux start-server
