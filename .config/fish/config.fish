set script_dir (dirname (status --current-filename))
fish_add_path $HOME/.local/bin
fish_add_path $HOME/.cargo/bin
set -x LD_LIBRARY_PATH "$LD_LIBRARY_PATH:/usr/local/lib/"
if test -e $script_dir/local.fish
    source $script_dir/local.fish
end
if status is-interactive
  # Commands to run in interactive sessions can go here
  set fish_color_valid_path
  set fish_greeting
  set -gx SHELL fish
  set -gx EDITOR hx
  if type -fq fzf
    if type -fq fd
      set -gx FZF_DEFAULT_COMMAND "fd --exclude={.git,.idea,.vscode,node_modules,build} --type f"
    else
      set -gx FZF_DEFAULT_COMMAND "find -type f ! -path \".git\" -! -path \"node_modules\" -! -path \"build\" -! -path \".vscode\" -! -path \".idea\""
    end
    set fzf_catppuccin "--color=bg+:#302D41,bg:#1E1E2E,spinner:#F8BD96,hl:#F28FAD --color=fg:#D9E0EE,header:#F28FAD,info:#DDB6F2,pointer:#F8BD96 --color=marker:#F8BD96,fg+:#F2CDCD,prompt:#DDB6F2,hl+:#F28FAD"
    set -gx FZF_DEFAULT_OPTS "$fzf_catppuccin --height 40% --layout=reverse 2> /dev/null | head -500'"
  end
  starship init fish | source
  if set -q ZELLIJ
  else
    zellij
  end
end
