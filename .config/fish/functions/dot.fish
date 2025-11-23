function dot --wraps=git --description 'Manage dotfiles repository with home as working directory'
    git --git-dir="$DOTFILES" --work-tree="$HOME" $argv
end
