if status is-interactive
    set fish_color_valid_path
    # Commands to run in interactive sessions can go here
    set -x EDITOR helix
    set -x FZF_DEFAULT_COMMAND "fd --exclude={.git,.idea,.vscode,node_modules,build} --type f"
    set -x FZF_DEFAULT_OPTS "--height 40% --layout=reverse --preview '(highlight -O ansi {} || cat {}) 2> /dev/null | head -500'"
end
