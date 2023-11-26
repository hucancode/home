#!/bin/sh

print_workspaces() {
    buf=""
    n=6
    focused=$(hyprctl activeworkspace -j | jq '.id')
    for (( i=1; i<=$n; i++ )) do
        occupied=$(hyprctl workspaces -j | jq ".[] | select(.id == $i and .windows > 0)")
        if [ "$focused" == "$i" ]; then
            icon="●"
            class="focused"
        elif [[ $occupied ]]; then
            icon="◉"
            class="occupied"
        else
            icon="○"
            class="empty"
        fi 
        buf="$buf (eventbox :cursor \"hand\" (button :class \"$class\" :onclick \"hyprctl dispatch workspace $i\" \"$icon\"))"
    done
    echo "(box :class \"workspaces\" :spacing 10 :halign \"center\" :valign \"center\" :vexpand true $buf)"
}

print_workspaces
socat -u UNIX-CONNECT:/tmp/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock - | while read -r line; do
    print_workspaces
done 
