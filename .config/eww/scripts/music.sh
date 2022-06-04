#!/bin/sh
# scripts by adi1090x

## Get status
get_status() {
	if [[ "$(mpc status)" == *"[playing]"* ]]; then
		echo ""
	else
		echo ""
	fi
}

## Get song
get_song() {
	song=`mpc -f "[[%artist% - ]%title%]|[%file%]" current`
	if [[ -z "$song" ]]; then
		echo "Offline"
	else
		echo $song
	fi	
}

## Execute accordingly
if [[ "$1" == "--song" ]]; then
    get_song
    mpc idleloop | while read -r _; do
    	get_song
    done
elif [[ "$1" == "--status" ]]; then
    get_status
    mpc idleloop | while read -r _; do
    	get_status
    done
elif [[ "$1" == "--toggle" ]]; then
	mpc toggle
elif [[ "$1" == "--next" ]]; then
	mpc next
elif [[ "$1" == "--prev" ]]; then
	mpc prev
fi
