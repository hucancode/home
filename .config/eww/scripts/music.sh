#!/bin/sh

## Get status
get_status() {
	mpc status | awk 'NR==2' | grep -q 'playing' && echo '' || echo ''
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

if [[ "$1" == "song" ]]; then
    get_song
    mpc idleloop player | while read -r _; do
    	get_song
    done
elif [[ "$1" == "status" ]]; then
    get_status
    mpc idleloop player | while read -r _; do
    	get_status
    done
fi
