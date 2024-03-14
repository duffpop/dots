export STARSHIP_CONFIG="$HOME/.config/themes/dracula/starship/starship.toml"

source "$HOME/.config/fish/conf.d/abbreviations.fish"


test -e {$HOME}/.iterm2_shell_integration.fish; and source {$HOME}/.iterm2_shell_integration.fish

if status is-interactive
    function starship_transient_prompt_func
        starship module character
    end

    function starship_transient_rprompt_func
        starship module time
    end

    starship init fish | source
    enable_transience

    brew shellenv | source
    atuin init fish --disable-up-arrow | source

    mise activate fish | source

    # argc-completions
    # set -gx ARGC_COMPLETIONS_ROOT /Users/duff/repos/duffpop/argc-completions
    # set -gx ARGC_COMPLETIONS_PATH "$ARGC_COMPLETIONS_ROOT/completions"
    # fish_add_path "$ARGC_COMPLETIONS_ROOT/bin"
    # # To add completions for only the specified command, modify next line e.g. set argc_scripts cargo git
    # set argc_scripts (ls -1 "$ARGC_COMPLETIONS_ROOT/completions" | sed -n 's/\.sh$//p')
    # argc --argc-completions fish $argc_scripts | source
end
