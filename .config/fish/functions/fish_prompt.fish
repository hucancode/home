function fish_prompt
    set -l last_exit_status $status
    set -l character_color red
    if test $last_exit_status -eq 0
        set character_color normal
    end
    set -g __fish_git_prompt_showcolorhints true
    set -g __fish_git_prompt_showstashstate true
    set -g __fish_git_prompt_showdirtystate true
    set -g __fish_git_prompt_char_stashstate '☰'
    set -g __fish_git_prompt_char_stagedstate '~'
    set -g __fish_git_prompt_char_dirtystate '*'
    set -g __fish_git_prompt_char_untrackedfiles '≈'
    set -g __fish_git_prompt_char_invalidstate '×'
    echo -n -s (set_color $fish_color_cwd) (prompt_pwd) (set_color -b brblack)(set_color normal) (fish_vcs_prompt) (set_color $character_color) ' ᐉ '
end
