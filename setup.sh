sudo curl https://sh.rustup.rs -sSf | sh
sudo apt-get install -y ripgrep
sudo snap install -y nvim --classic
sudo apt-get install -y unzip
sudo apt install -y python3-pip
sudo apt install -y python3-venv
sudo apt install -y ipython3
sudo apt install -y npm 

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

tmux kill-server
tmux start-server
