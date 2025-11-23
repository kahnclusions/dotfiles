set -x DOTFILES $HOME/.dotfiles
set -x BROWSER w3m
set -x EDITOR nvim
# set -x GPG_TTY (tty)
# set -x PINENTRY_USER_DATA USE_CURSES=0
set -x APPLE_DEVELOPMENT_TEAM 9L24T24M6Z
set fish_greeting

fish_add_path -m $HOME/.brew/bin
fish_add_path -m $HOME/.cargo/bin
fish_add_path -m ~/.local/bin
fish_add_path -m ~/.rbenv/shims

if status is-interactive
    # starship init fish | source

    alias ls="eza --icons --header --git --group-directories-first"
    alias l="eza --icons --oneline --git --group-directories-first"
    alias ll="eza --icons --long --header --git --group-directories-first --octal-permissions --no-permissions --time-style=long-iso"
    alias lt="eza --tree --git --icons"
    alias la="eza --all --icons --long --header --git --group-directories-first --octal-permissions --no-permissions --time-style=long-iso"
end

alias dots="cd $DOTFILES"
# alias gp="git pull"
# alias gP="git push"
# alias gs="git status"
# alias gb="git checkout -b"
# alias gc="git checkout"
# alias gS="git stash"
# alias grm="git rebase origin/master"
# alias gri="git rebase -i"

# pnpm
# set -gx PNPM_HOME "/Users/ck/Library/pnpm"
# set -gx PATH "$PNPM_HOME" $PATH
# pnpm end

function update_theme --on-variable macOS_Theme
    if [ "$macOS_Theme" = "dark" ]
        source "$HOME/.config/fish/themes/Kanagawa_Wave.fish"
    else if [ "$macOS_Theme" = "light" ]
        source "$HOME/.config/fish/themes/Kanagawa_Lotus.fish"
    end
end

# set -Ux FZF_DEFAULT_OPTS "$FZF_DEFAULT_OPTS \
#     --color=fg:#c0caf5,bg:#24283b,hl:#ff9e64 \
#     --color=fg+:#c0caf5,bg+:#292e42,hl+:#ff9e64 \
#     --color=info:#7aa2f7,prompt:#7dcfff,pointer:#7dcfff \
#     --color=marker:#9ece6a,spinner:#9ece6a,header:#9ece6a"
#
# set system_theme (defaults read -g AppleInterfaceStyle 2> /dev/null)
#
# if [ "$system_theme" = "Dark" ];
#   set -U macOS_Theme "dark"
#     # fish_config theme save "Catppuccin Mocha"
# else;
#   set -U macOS_Theme "light"
#     # fish_config theme save "Catppuccin Latte"
# end

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
# if test -f /opt/homebrew/Caskroom/miniconda/base/bin/conda
#     eval /opt/homebrew/Caskroom/miniconda/base/bin/conda "shell.fish" "hook" $argv | source
# else
#     if test -f "/opt/homebrew/Caskroom/miniconda/base/etc/fish/conf.d/conda.fish"
#         . "/opt/homebrew/Caskroom/miniconda/base/etc/fish/conf.d/conda.fish"
#     else
#         set -x PATH "/opt/homebrew/Caskroom/miniconda/base/bin" $PATH
#     end
# end
# <<< conda initialize <<<

# rvm default

if test (uname) = Darwin
    fish_add_path --prepend --global "$HOME/.nix-profile/bin" /nix/var/nix/profiles/default/bin /run/current-system/sw/bin
end

set -q GHCUP_INSTALL_BASE_PREFIX[1]; or set GHCUP_INSTALL_BASE_PREFIX $HOME ; set -gx PATH $HOME/.cabal/bin /Users/ck/.ghcup/bin $PATH # ghcup-env
