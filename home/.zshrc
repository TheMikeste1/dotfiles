# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

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
zinit ice depth"1"
zinit light romkatv/powerlevel10k
zinit ice depth=1
zinit light jeffreytse/zsh-vi-mode
# Postpone loading fzf so it doesn't get messed up by vi mode
zinit ice lucid wait
zinit snippet OMZP::fzf

# Add in snippets
zinit snippet OMZP::sudo
zinit snippet OMZP::command-not-found

# Load completions
autoload -Uz compinit && compinit

zinit cdreplay -q

# Keybindings
bindkey -v
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^[w' kill-region

# Replace sudo bindings so as to not slow down vi mode
bindkey -M emacs -r '\e\e'
bindkey -M vicmd -r '\e\e'
bindkey -M viins -r '\e\e'
bindkey -M emacs '^[`' sudo-command-line
bindkey -M vicmd '^[`' sudo-command-line
bindkey -M viins '^[`' sudo-command-line

# In Vi mode, we need these for abbr to work
# <https://zsh-abbr.olets.dev/advanced.html#alternative-keymaps>
bindkey -M viins " " abbr-expand-and-insert
bindkey -M viins "^ " magic-space
bindkey -M viins "^M" abbr-expand-and-accept

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

eval "$(mise activate zsh)"
source <(fzf --zsh)
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

zinit light zsh-users/zsh-syntax-highlighting # Must be loaded last to load all completions
