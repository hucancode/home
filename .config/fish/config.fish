set script_dir (dirname (status --current-filename))
if status is-interactive
    # Commands to run in interactive sessions can go here
    set fish_color_valid_path
    set fish_greeting
    set -gx SHELL fish
    set -gx EDITOR helix
    set -gx FZF_DEFAULT_COMMAND "fd --exclude={.git,.idea,.vscode,node_modules,build} --type f"
    set -gx FZF_DEFAULT_OPTS "--height 40% --layout=reverse 2> /dev/null | head -500'"
    starship init fish | source
end
if test -e $script_dir/local.fish
    source $script_dir/local.fish
end
