#!/bin/sh

echo $$ > /tmp/barsh_id

function bar_vol() {
	export VOL=$( amixer | \
	grep 'Front Left: Playback' | \
	cut -d' ' -f 7- | \
	tr '[]' ' ' | \
	awk '{if ( $2 == "on" ) { print $1; } else { print 0; }}' )
}

function bar_netw() {
	export SSID=$(iwgetid -r)
}

function bar_mem() {
	export MEM=$( free | \
	 sed -n '2p' | \
	 awk '{ GB=(1024*1024) ; printf("%.1f/%.1f G",$7/GB,$2/GB) }' )
 }

function bar_time() {
	export TIME=$( date +"%a %Y-%m-%d %H:%M" )
}

function bar_pow() {
	export POW=$(cat \
	/sys/class/power_supply/BAT0/charge_now \
	/sys/class/power_supply/BAT0/charge_full | \
	tr '\n' ' ' | \
	awk '{ printf("%d%%",100 * ($1/$2)); }')
}

function bar_redraw() {
	bar_vol
	bar_netw
	bar_mem
	bar_time
	bar_pow
	xsetroot -name "${VOL} ${SSID} ${MEM} ${TIME} ${POW}"
}

function bar_force_redraw() {
	bar_vol
	xsetroot -name "${VOL} ${SSID} ${MEM} ${TIME} ${POW}"
}

trap bar_force_redraw 12

while [ true ]; do
	bar_redraw
	S=$(date +"%S")
	S=$( echo $S | awk '{ V=( 60 - $1) % 60 ; if ( V < 0 ) { V = 60 + V } ; print V ; }' || echo 1 )
	sleep $S & # enforce one update per minute
	wait
done

rm /tmp/barsh_id
