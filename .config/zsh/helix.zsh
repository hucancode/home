export EDITOR='helix'
export FZF_DEFAULT_COMMAND="fd --exclude={.git,.idea,.vscode,node_modules,build} --type f"
export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --preview '(highlight -O ansi {} || cat {}) 2> /dev/null | head -500'"
