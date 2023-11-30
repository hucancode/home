set script_dir (dirname (status --current-filename))
set -gx BUN_INSTALL $HOME/.bun
fish_add_path $BUN_INSTALL/bin
fish_add_path $HOME/go/bin
fish_add_path $HOME/.local/bin
fish_add_path $HOME/.cargo/bin
set -x LD_LIBRARY_PATH "$LD_LIBRARY_PATH:/usr/local/lib/"
if test -e $script_dir/local.fish
    source $script_dir/local.fish
end
if status is-interactive
  # Commands to run in interactive sessions can go here
  set fish_color_valid_path
  set -U fish_key_bindings fish_default_key_bindings
  set -gx SHELL fish
  set -gx EDITOR hx
end
