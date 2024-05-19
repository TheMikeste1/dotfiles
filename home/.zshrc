# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

if [[ -f "$HOME"/.bash_env ]]; then
    source "$HOME"/.bash_env
fi

# TMUX autoconnect
if [[ "$TMUX" = "" ]]; then
    # Automatically connect to the session
    sessions=$(tmux ls -F "#{session_name}:#{session_attached}" 2> /dev/null)
    for s in "${sessions[@]}";
    do
        parts=("${(s/:/)s}")
        if [ "${parts[1]}" = "default" ]; then
            default_session_state=${parts[2]}
            break
        fi
    done

    if [[ "$default_session_state" = "" ]]; # Session does not exist
    then
        tmux new -s default >/dev/null
    elif [[ "$default_session_state" = 0 ]]; # Session exists but is not attached
    then
        tmux attach -t default
    fi
fi

# Download Zinit, if it's not there yet
if [[ ! -d "$ZINIT_HOME" ]]; then
    echo "Zinit not found, installing. . ."
    mkdir -p "$(dirname "$ZINIT_HOME")"
    git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

export PATH="$HOME/.cargo/bin:$PATH"

# Add in zsh plugins
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light olets/zsh-abbr
zinit light Aloxaf/fzf-tab

# Add in snippets
zinit snippet OMZP::sudo
zinit snippet OMZP::command-not-found

# Load completions
autoload -Uz compinit && compinit

zinit cdreplay -q

# Keybindings
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^[w' kill-region

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}' # Set case insensitive
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'

if [[ -f "$HOME"/.bash_commands ]]; then
    source "$HOME"/.bash_commands
fi

if [[ -f "$HOME"/.bash_aliases ]]; then
    source "$HOME"/.bash_aliases
fi

# Start SSH agent on launch
ssh-activate

eval "$(starship init zsh)"
eval "$(mise activate zsh)"
source <(fzf --zsh)

zinit light zsh-users/zsh-syntax-highlighting # Must be loaded last to load all completions

