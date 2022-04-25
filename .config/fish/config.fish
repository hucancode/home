set script_dir (dirname (status --current-filename))
if status is-interactive
    # Commands to run in interactive sessions can go here
    set fish_color_valid_path
    set fish_greeting
    set -x SHELL fish
    set -x EDITOR helix
    set -x FZF_DEFAULT_COMMAND "fd --exclude={.git,.idea,.vscode,node_modules,build} --type f"
    set -x FZF_DEFAULT_OPTS "--height 40% --layout=reverse --preview '(highlight -O ansi {} || cat {}) 2> /dev/null | head -500'"
    if test -e $script_dir/local.fish
        source $script_dir/local.fish
    end
end
