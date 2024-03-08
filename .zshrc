# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

if [ -f $(brew --prefix)/etc/brew-wrap ];then
  source $(brew --prefix)/etc/brew-wrap
fi

source /opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme

plugins=(
    git pip python gh colored-man-pages command-not-found you-should-use 1password macos git-open zsh-syntax-highlighting zsh-autosuggestions 
)

fpath+=~/.zfunc
FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
export ZSH="$HOME/.oh-my-zsh"
source $ZSH/oh-my-zsh.sh

zstyle ':omz:auto' frequency auto

eval "$(atuin init zsh --disable-up-arrow)"

function ya() {
    tmp="$(mktemp -t "yazi-cwd.XXXXX")"
    yazi --cwd-file="$tmp"
    if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
        cd -- "$cwd"
    fi
    rm -f -- "$tmp"
}

export EDITOR=nvim
CONFIG_HOME="$HOME/.config/"
export XDG_CONFIG_HOME="$CONFIG_HOME"
export HOMEBREW_XDG_CONFIG_HOME="$CONFIG_HOME"
export SSH_AUTH_SOCK=~/Library/Group\ Containers/2BUA8C4S2C.com.1password/t/agent.sock


alias reload="exec $SHELL -l"
alias nz="nvim $HOME/.zshrc"
alias n=nvim
alias tl=tldr
alias cat=bat
alias ccat="bat --style=plain"
alias ls=lsd
alias l="lsd -lAh"
alias ll="lsd -lh"
alias md="mkdir -p"
alias dl="cd $HOME/Downloads"
alias dt="cd $HOME/Desktop"
alias arpa="arp -a | awk '{print \$4}' | xargs -I {} sh -c 'echo {}; sleep 1; curl -s https://api.macvendors.com/{}'"
alias repos="cd $HOME/repos/"
alias bunx="bun x"
alias repos="cd $HOME/repos/"
alias cko="cd $HOME/repos/cko/"
alias ,conf="cd $CONFIG_HOME"

# function docker() {
#   if [ "$1" = "ls" ]; then
#     shift 1
#     command docker ps --format "{{.Names}}\t{{.Ports}}" | awk -F "\t" '{print $1, $2}'
#   else
#     command docker "$@"
#   fi
# }

function mdd() {
    mkdir -p "$@" && cd "$_"
}

function o() {
    if [ $# -eq 0 ]; then
        open .
    else
        open "$@"
    fi
}

function pcat() {
    cat "$1" | pbcopy
}

function bf() {
    brew ls | rg "$1"
}

function c() {
    if [ $# -eq 0 ]; then
        code-insiders .
    else
        code-insiders "$@"
    fi
}

function csr() {
    if [ $# -eq 0 ]; then
        cursor .
    else
        cursor "$@"
    fi
}
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# eval "$(mise activate zsh)"

eval "$(mise activate zsh)"

# pnpm
export PNPM_HOME="/Users/duff/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/homebrew/Caskroom/miniconda/base/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/homebrew/Caskroom/miniconda/base/etc/profile.d/conda.sh" ]; then
        . "/opt/homebrew/Caskroom/miniconda/base/etc/profile.d/conda.sh"
    else
        export PATH="/opt/homebrew/Caskroom/miniconda/base/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

printf '\eP$f{"hook": "SourcedRcFileForWarp", "value": { "shell": "zsh" }}\x9c'

