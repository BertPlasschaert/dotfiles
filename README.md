## requirements
- git
- stow
```
sudo apt update
```
```
sudo apt install git
```
```
sudo apt install stow
```

## clone recursively to get nvim config as well
```
git clone git@github.com:BertPlasschaert/dotfiles.git --recurse-submodules
```

## steps

clone dotfiles repo (this repo) to user home dir.
cd inside the repo and run the `stow .` command.
run the setup script `. setup.sh`

### zsh users only
`stow` can't manage `~/.zshrc` directly (it's not a fresh symlink target —
you already have real content in there). Add one line to your own
`~/.zshrc` to pick up the PATH additions (nvim/tmux/tree-sitter) that
`.bashrc` gets for free via stow:
```
source "$HOME/.path.sh"
```

open Tmux and press: `<leader> + I` (capital i to update the tpm mods)

Inside Nvim run: `Lazy sync` to install plugins (there's no locked/pinned versions anymore — nvim itself is pinned instead, see `.config/nvim/README.md`)

## sources
https://youtu.be/NoFiYOqnC4o?si=UOuRPs2sm7nKaEXj
https://youtu.be/y6XCebnB9gs?si=UwiQlEEoEqyaZ47O

### using ssh with submodules
https://www.damirscorner.com/blog/posts/20210423-ChangingUrlsOfGitSubmodules.html




