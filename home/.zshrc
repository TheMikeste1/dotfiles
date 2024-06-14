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
    exec tmux new -s default >/dev/null
  elif [[ "$default_session_state" = 0 ]]; # Session exists but is not attached
  then
    exec tmux attach -t default
  fi
fi

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

if [[ -f "$HOME"/.bash_env ]]; then
  source "$HOME"/.bash_env
fi

# Download Zinit, if it's not there yet
if [[ ! -d "$ZINIT_HOME" ]]; then
  echo "Zinit not found, installing. . ."
  mkdir -p "$(dirname "$ZINIT_HOME")"
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Add in zsh plugins
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
ZSH_AUTOSUGGEST_USE_ASYNC=true
zinit light olets/zsh-abbr
zinit light Aloxaf/fzf-tab
zinit ice depth"1"
zinit light romkatv/powerlevel10k
zinit ice depth=1

zinit light jeffreytse/zsh-vi-mode
ZVM_LINE_INIT_MODE=$ZVM_MODE_INSERT

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
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^[w' kill-region

# Vi insert
bindkey -M viins -r '\e\e'
bindkey -M viins '^[`' sudo-command-line
# In Vi mode, we need these for abbr to work
# <https://zsh-abbr.olets.dev/advanced.html#alternative-keymaps>
bindkey -M viins " " abbr-expand-and-insert
bindkey -M viins "^ " magic-space
bindkey -M viins "^M" abbr-expand-and-accept

# Emacs
bindkey -M emacs -r '\e\e'
bindkey -M emacs '^[`' sudo-command-line

# Vi normal/command and visual
function zvm_after_lazy_keybindings() {
  # Replace sudo bindings so as to not slow down vi mode
  bindkey -M vicmd '^[`' sudo-command-line
  bindkey -M vicmd -r '\e\e'
}

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
zstyle ':fzf-tab:complete:git*:*' fzf-preview

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

# TODO: Customize
# Source: <https://www.reddit.com/r/zsh/comments/ass2tc/gitadd_completion_with_full_paths_listed_at_once/>
__git_status_files() {
  local -a status_files=( "${"${(0)"$(git status -z)"}"}" )
  local -a unstaged_files
  local -a staged_files
  for entry in "$status_files"; do
    local stts=$entry[1,3]
    local file=$entry[4,-1]

    if [[ $stts[2] != ' ' ]]
    then
      unstaged_files+=$file
    fi

    if [[ $stts[1] != ' ' ]] && [[ $stts[1] != '?' ]]
    then
      staged_files+=$file
    fi
  done

  _describe -t unstaged 'Unstaged' unstaged_files && ret=0
  _describe -t staged 'Staged' staged_files && ret=0

  return "$ret"
}

__git_staged_files() {
  local -a staged_files=( "${"${(0)"$(git diff-index -z --name-only --no-color --cached HEAD)"}"}" )
  _describe -t staged 'Staged files' staged_files && ret=0
  return "$ret"
}

__git_modified_files() {
  __git_status_files
}

__git_treeish-to-index_files() {
  __git_staged_files
}

__git_other_files() {
  true
}

zinit light zsh-users/zsh-syntax-highlighting # Must be loaded last to load all completions
