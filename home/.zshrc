# Set the directory we want to store zinit and plugins
readonly ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

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
export ZSH_AUTOSUGGEST_USE_ASYNC=true
zinit light olets/zsh-abbr
zinit light Aloxaf/fzf-tab

# Postpone loading fzf so it doesn't get messed up by vi mode
# zinit ice lucid wait
zinit snippet OMZP::fzf

# Add in snippets
zinit snippet OMZP::sudo
zinit snippet OMZP::command-not-found

# Load completions
autoload -Uz compinit
# Load compinit from the cache if it's been less than 24 hours
setopt extendedglob local_options
if [[ -n "${ZDOTDIR:-$HOME}"/.zcompdump(#qN.mh+24) ]]; then
  echo "Refreshing compinit cache. . ."
  compinit
else
  compinit -C
fi
unsetopt extendedglob local_options

zinit cdreplay -q

if [[ -f "$HOME"/.bash_aliases ]]; then
  source "$HOME"/.bash_aliases
fi

readonly EVAL_CACHE_DIR="$HOME/.cache/eval"
if [[ ! -d "$EVAL_CACHE_DIR" ]]; then
  mkdir -p "$EVAL_CACHE_DIR"
fi

setopt extendedglob local_options
if [ ! -f "$EVAL_CACHE_DIR"/.last_cache ] || [[ -n "$EVAL_CACHE_DIR"/.last_cache(#qN.mh+24) ]]; then
  echo "Refreshing eval cache. . ."
  oh-my-posh init zsh --config ~/.dotfiles/configs/oh-my-posh/theme_default.yaml > "$EVAL_CACHE_DIR/oh-my-posh_init.zsh"
  oh-my-posh completion zsh > "$EVAL_CACHE_DIR/oh-my-posh_comp.zsh"
  mise activate zsh > "$EVAL_CACHE_DIR/mise_init.zsh"
  mise completions zsh > "$EVAL_CACHE_DIR/mise_comp.zsh"
  fzf --zsh > "$EVAL_CACHE_DIR/fzf_comp.zsh"
  touch "$EVAL_CACHE_DIR"/.last_cache
fi
unsetopt extendedglob local_options

source "$EVAL_CACHE_DIR/oh-my-posh_init.zsh"
source "$EVAL_CACHE_DIR/oh-my-posh_comp.zsh"
source "$EVAL_CACHE_DIR/mise_init.zsh"
source "$EVAL_CACHE_DIR/mise_comp.zsh"
source "$EVAL_CACHE_DIR/fzf_comp.zsh"

zinit light zsh-users/zsh-syntax-highlighting # Must be loaded last to load all completions

# Keybindings
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^[w' kill-region
bindkey '^l' autosuggest-accept

# Vi insert
bindkey -M viins -r '\e\e'
bindkey -M viins '^[`' sudo-command-line
# In Vi mode, we need these for abbr to work
# <https://zsh-abbr.olets.dev/advanced.html#alternative-keymaps>
bindkey -M viins " " abbr-expand-and-insert
bindkey -M viins "^ " magic-space
bindkey -M viins "^M" abbr-expand-and-accept

# Vi normal/command and visual
function zvm_after_lazy_keybindings() {
  # Replace sudo bindings so as to not slow down vi mode
  bindkey -M vicmd '^[`' sudo-command-line
  bindkey -M vicmd -r '\e\e'
}

# Emacs
bindkey -M emacs -r '\e\e'
bindkey -M emacs '^[`' sudo-command-line
bindkey -M emacs " " abbr-expand-and-insert
bindkey -M emacs "^ " magic-space
bindkey -M emacs "^M" abbr-expand-and-accept

# History
export HISTSIZE=5000
export HISTFILE=~/.zsh_history
export SAVEHIST=$HISTSIZE
export HISTDUP=erase
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
zstyle ':fzf-tab:complete:cd:*' fzf-preview "ls --color \$realpath"
zstyle ':fzf-tab:complete:git*:*' fzf-preview

# TODO: Customize
# Source: <https://www.reddit.com/r/zsh/comments/ass2tc/gitadd_completion_with_full_paths_listed_at_once/>
__git_status_files() {
  # TODO: Update to use porcelain instead of raw status
  local -a status_files=( "${(@f)"$(git status -s)"}" )
  local -a staged_files
  local -a unstaged_files
  for entry in "${status_files[@]}"; do
    if [[ "$entry" == '' ]];
    then
      continue
    fi

    local stts="${entry[1,3]}"
    local file="${entry[4,-1]}"

    if [[ "${stts[1]}" != ' ' ]] && [[ "${stts[1]}"  != '?' ]];
    then
      staged_files+=$file
    fi

    if [[ "${stts[2]}" != ' ' ]];
    then
      unstaged_files+=$file
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
  # TODO: Update to use porcelain instead of raw status
  local -a status_files=( "${(@f)"$(git status -s)"}" )
  local -a unstaged_files
  for entry in "${status_files[@]}"; do
    if [[ "$entry" == '' ]];
    then
      continue
    fi

    local stts="${entry[1,3]}"
    local file="${entry[4,-1]}"

    if [[ "${stts[2]}" != ' ' ]];
    then
      unstaged_files+=$file
    fi
  done

  _describe -t unstaged 'Unstaged' unstaged_files && ret=0

  return "$ret"
}

__git_treeish-to-index_files() {
  __git_staged_files
}

__git_other_files() {
  return 0
}
