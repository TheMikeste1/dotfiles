skip_global_compinit=1

if [[ -f "$HOME"/.bash_env ]]; then
  source "$HOME"/.bash_env
fi

if [[ -f "$HOME"/.bash_commands ]]; then
  source "$HOME"/.bash_commands
fi
