# dotfiles

These are my configuration files for my personal `macOS` setup. They are installed as a git repository checked out directly into my home directory.

## Install

```bash
git clone --bare https://git.ck.dev/toph/dotfiles.git ~/.dotfiles
git --git-dir=.dotfiles --work-tree=. reset --hard
git --git-dir=.dotfiles config --local status.showUntrackedFiles no
brew bundle --file=$HOME/.meta/Brewfile
```

## Manage

I use a fish function to manage the dotfiles git repository called `dot` which is just an alias for `git --git-dir="$DOTFILES" --work-tree="$HOME"`.

```bash
dot status
dot add .config/fish/config.fish
```

