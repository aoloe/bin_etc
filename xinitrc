[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources

# start ssh-agent, which we will need for ssh-add
eval `/usr/bin/ssh-agent`

# 1280x720 = 720p X220
# hash fswebcam && fswebcam -q --no-banner -r 1280x720 ~/private/login-photos/$(date +%Y-%m-%dT%H).jpg &

# xrdb -merge $HOME/.Xresources

export CHROMIUM_FLAGS='--enable-remote-extensions'

# https://wiki.archlinux.org/index.php/Java#Non-reparenting_window_managers
export _JAVA_AWT_WM_NONREPARENTING=1

# export QT_SCALE_FACTOR=1.5

setxkbmap ch -variant fr

# cf. http://dwm.suckless.org/dowmstatus/
# for colors in the status bar, a patch is necessary: https://unix.stackexchange.com/questions/81102/cannot-echo-colored-text-when-inserting-in-status-bar-in-dwm
# https://dwm.suckless.org/patches/statuscolors/
status() {
	LOCALTIME=$(date "+%a %d %h %H:%M")
	# TEMP="$(($(cat /sys/class/thermal/thermal_zone0/temp) / 1000))C"

	# BAT="Bat. $(acpi -b | awk '{ print $4 " " $5 }' | tr -d ',')"
	BAT=$(acpi -b |tr -d ','|awk '{if ($3=="Discharging") {print "-[ ]· " $4 " (" $5 ")"} else {print "-[|= " $4}}')
    BAT_TIME=$(acpi -b | awk '{print $5}' | tr ':' ' ' | awk '{print $1 * 60 + $2}')
    if [ $BAT_TIME -gt 0 && $BAT_TIME -lt 10 ]; then
        BAT="$(printf '\4') $BAT $(printf '\1')"
    fi

	LOAD=$(uptime | sed 's/.*://; s/, / /g' | awk '{print $1}')

    # i have a bug and my laptop crashes if there is no RAM around: warn if there is less than 1 GB free
    MEM=$(free | head -2 | tail -1 | awk '{print $4}')
    if [ $MEM -gt 1000000 ]; then
        MEM=''
    else
        MEM="$(expr $MEM / 1000) MB"
        MEM="$(printf '\3') $MEM $(printf '\1') |"
    fi

    A=`printf \x04`
    B=`printf \x01`
	# xsetroot -name "$(printf '\x04' $BAT $(printf '\x01') | $LOAD | $LOCALTIME"
	# xsetroot -name "$A $BAT $B | $LOAD | $LOCALTIME"
	xsetroot -name "$MEM$BAT | $LOAD | $LOCALTIME"
}

while true
do
	status
	sleep 20s
done &

exec dwm
