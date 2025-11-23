#!/usr/bin/env sh

echo "Installing..."

if [[ -z "${DEPLOY_ENV}" ]]; then
    DOTFILES="$HOME/.dotfiles"
    echo "Using default dotfiles location: $DOTFILES"
else
    DOTFILES="${DOTFILES}"
fi

echo "Installing Brewfile"
brew bundle

if [[ "$SHELL" != "$(which fish)" ]]; then
    echo "Setting Fish as default shell"
    sudo sh -c 'echo $(which fish) >> /etc/shells'
    chsh -s $(which fish)

    curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher
    fisher install jorgebucaran/nvm.fish
    fisher install PatrickF1/fzf.fish
fi

echo "Done."
