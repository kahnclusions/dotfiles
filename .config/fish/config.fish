set -x DOTFILES $HOME/.dotfiles
# set -x JAVA_HOME (sdk home java 17.0.3-tem)
set -x BROWSER w3m
set -x EDITOR nvim
set -x GPG_TTY (tty)
set -x ANDROID_HOME $HOME/Library/Android/sdk
set -x PINENTRY_USER_DATA USE_CURSES=0
set fish_greeting

fish_add_path -m $HOME/.brew/bin
fish_add_path -m $HOME/Library/Application\ Support/Coursier/bin
fish_add_path -m $HOME/.cargo/bin
fish_add_path -m ~/.local/bin
fish_add_path -m $ANDROID_HOME/tools
fish_add_path -m $ANDROID_HOME/platform-tools
fish_add_path -m $HOME/workspace/flutter/bin

if status is-interactive
    starship init fish | source

    alias ls="exa --icons --header --git --group-directories-first"
    alias l="exa --icons --oneline --git --group-directories-first"
    alias ll="exa --icons --long --header --git --group-directories-first --octal-permissions --no-permissions --time-style=long-iso"
    alias lt="exa --tree --git --icons"
    alias la="exa --all --icons --long --header --git --group-directories-first --octal-permissions --no-permissions --time-style=long-iso"
end

alias dots="cd $DOTFILES"
alias gp="git pull"
alias gP="git push"
alias gs="git status"
alias gb="git checkout -b"
alias gc="git checkout"
alias gS="git stash"
alias grm="git rebase origin/master"
alias gri="git rebase -i"

# pnpm
set -gx PNPM_HOME "/Users/ck/Library/pnpm"
set -gx PATH "$PNPM_HOME" $PATH
# pnpm end

function update_theme --on-variable macOS_Theme
    if [ "$macOS_Theme" = "dark" ]
        # source "$HOME/.config/fish/themes/Zenbones Dark.fish"
    else if [ "$macOS_Theme" = "light" ]
        # source "$HOME/.config/fish/themes/Kanagawa_Lotus.fish"
    end
end

set -Ux FZF_DEFAULT_OPTS "$FZF_DEFAULT_OPTS \
    --color=fg:#c0caf5,bg:#24283b,hl:#ff9e64 \
    --color=fg+:#c0caf5,bg+:#292e42,hl+:#ff9e64 \
    --color=info:#7aa2f7,prompt:#7dcfff,pointer:#7dcfff \
    --color=marker:#9ece6a,spinner:#9ece6a,header:#9ece6a"

set system_theme (defaults read -g AppleInterfaceStyle 2> /dev/null)

if [ "$system_theme" = "Dark" ];
  set -U macOS_Theme "dark"
else;
  set -U macOS_Theme "light"
end

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
if test -f /opt/homebrew/Caskroom/miniconda/base/bin/conda
    eval /opt/homebrew/Caskroom/miniconda/base/bin/conda "shell.fish" "hook" $argv | source
else
    if test -f "/opt/homebrew/Caskroom/miniconda/base/etc/fish/conf.d/conda.fish"
        . "/opt/homebrew/Caskroom/miniconda/base/etc/fish/conf.d/conda.fish"
    else
        set -x PATH "/opt/homebrew/Caskroom/miniconda/base/bin" $PATH
    end
end
# <<< conda initialize <<<

rvm default
