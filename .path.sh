# Shared PATH additions for tools installed by setup.sh (nvim, tmux,
# tree-sitter-cli — all pinned versions in /opt, not from the system package
# manager). Sourced from both .bashrc and ~/.zshrc so it works regardless of
# shell — see README.md for the one-line zsh setup this needs.
export PATH="$PATH:/opt/nvim/bin:/opt/tmux/bin:/opt/tree-sitter/bin"
