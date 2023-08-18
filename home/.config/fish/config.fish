if status is-interactive
    # Commands to run in interactive sessions can go here
end


if [ -f ~/.bash_aliases ]
    . ~/.bash_aliases
end

if [ -f ~/.bash_env ]
    . ~/.bash_env
end

set script_directory $(dirname (readlink -m (status --current-filename)))
source "$script_directory/local.config.fish" 2> /dev/null

# Start SSH agent on launch
ssh-activate

# Starship
starship init fish | source
