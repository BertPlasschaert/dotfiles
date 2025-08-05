sudo curl https://sh.rustup.rs -sSf | sh -s -- -y
sudo apt-get install -y ripgrep
sudo apt-get install -y unzip
sudo apt install -y python3-pip
sudo apt install -y python3-venv
sudo apt install -y ipython3
sudo apt install -y npm

sudo rm -rf /opt/nvim
sudo rm -rf nvim-linux-x86_64.tar.gz
sudo curl -LO https://github.com/neovim/neovim/releases/download/v0.10.4/nvim-linux-x86_64.tar.gz && sudo tar -xzf nvim-linux-x86_64.tar.gz && sudo mv nvim-linux-x86_64 /opt/nvim && sudo rm -rf nvim-linux-x86_64.tar.gz

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

tmux kill-server
tmux start-server
