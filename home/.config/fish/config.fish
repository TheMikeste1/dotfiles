if [ -f ~/.bash_env ]
    . ~/.bash_env
end

set script_directory $(dirname (readlink -m (status --current-filename)))
set fish_function_path $fish_function_path "$script_directory/functions/user"
set fish_complete_path $fish_complete_path "$script_directory/completions/user"

if status is-interactive
    # Commands to run in interactive sessions can go here
    function fish_user_key_bindings
        # Execute this once per mode that emacs bindings should be used in
        fish_default_key_bindings -M insert

        # Then execute the vi-bindings so they take precedence when there's a conflict.
        # Without --no-erase fish_vi_key_bindings will default to
        # resetting all bindings.
        # The argument specifies the initial mode (insert, "default" or visual).
        fish_vi_key_bindings --no-erase insert
    end

    fzf_configure_bindings --variables=\e\cv
end

export LESS_TERMCAP_mb=\e'[1;31m' # begin bold
export LESS_TERMCAP_md=\e'[1;36m' # begin blink
export LESS_TERMCAP_me=\e'[0m' # reset bold/blink
export LESS_TERMCAP_so=\e'[01;44;33m' # begin reverse video
export LESS_TERMCAP_se=\e'[0m' # reset reverse video
export LESS_TERMCAP_us=\e'[1;32m' # begin underline
export LESS_TERMCAP_ue=\e'[0m' # reset underline
abbr --add --position command G git

# Start SSH agent on launch
ssh-activate

starship init fish | source

if [ -f ~/.bash_aliases ]
    . ~/.bash_aliases
end

source "$script_directory/local.config.fish" 2>/dev/null
