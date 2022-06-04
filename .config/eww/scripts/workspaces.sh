#!/bin/sh

# Checks if a list ($1) contains an element ($2)
contains() {
    for e in $1; do
        [ "$e" -eq "$2" ] && echo 1 && return 
    done
    echo 0
}

print_workspaces() {
    buf=""
    desktop_count=$(xdotool get_num_desktops)
    focused_desktop=$(xdotool get_desktop)
    for (( i=0; i<$desktop_count; i++ )) do
        if [ "$focused_desktop" == "$i" ]; then
            ws=$d
            icon=" "
            class="workspace-focused"
        else 
            ws=$d
            icon=" "
            class="workspace-empty"
        fi  
        buf="$buf (eventbox :cursor \"hand\" (button :class \"$class\" :onclick \"xdotool set_desktop $i\" \"$icon\"))"
    done
    echo "(box :orientation \"h\" :class \"workspaces\" :spacing 10 :halign \"center\" :valign \"center\" :vexpand true :hexpand false $buf)"
}

# Listen to bspwm changes
print_workspaces
xprop -spy -root _NET_CURRENT_DESKTOP | while read -r _ ; do
    print_workspaces
done 
