function fish_prompt
    set -l last_exit_status $status
    set -l character_color red
    if test $last_exit_status -eq 0
        set character_color normal
    end
    echo -n -s (set_color $fish_color_cwd) (prompt_pwd) (set_color brblue) (fish_vcs_prompt) (set_color $character_color) ' ᐉ '
end
