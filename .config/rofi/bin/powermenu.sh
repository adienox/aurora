#!/usr/bin/env bash

rofi_command="rofi -theme $HOME/.config/rofi/config/powermenu.rasi"
ddir=~/.config/rofi/config

shutdown=""
reboot=""
lock=""
suspend="󰤄"
logout="󰗽"

# Ask for confirmation
rdialog () {
    rofi -dmenu\
        -i\
        -no-fixed-num-lines\
        -p "Are You Sure? : "\
        -theme "$ddir/confirm.rasi"
}

# Display Help
show_msg() {
    rofi -theme "$ddir/askpass.rasi" -e "Options : yes / no / y / n"
}

# Variable passed to rofi
options="$lock\n$logout\n$suspend\n$reboot\n$shutdown"

chosen="$(echo -e "$options" | $rofi_command -dmenu -selected-row 0 -kb-row-up k,Up -kb-row-down j,Down -kb-accept-entry l,KP_Enter,Return)"
case $chosen in
    $shutdown)
        ans=$(rdialog &)
        if [[ $ans == "yes" ]] || [[ $ans == "YES" ]] || [[ $ans == "y" ]]; then
            systemctl poweroff
        elif [[ $ans == "no" ]] || [[ $ans == "NO" ]] || [[ $ans == "n" ]]; then
            exit
        else
            show_msg
        fi
        ;;
    $reboot)
        ans=$(rdialog &)
        if [[ $ans == "yes" ]] || [[ $ans == "YES" ]] || [[ $ans == "y" ]]; then
            systemctl reboot
        elif [[ $ans == "no" ]] || [[ $ans == "NO" ]] || [[ $ans == "n" ]]; then
            exit
        else
            show_msg
        fi
        ;;
    $lock)
        gtklock
        ;;
    $suspend)
        ans=$(rdialog &)
        if [[ $ans == "yes" ]] || [[ $ans == "YES" ]] || [[ $ans == "y" ]]; then
            gtklock
            systemctl suspend
        elif [[ $ans == "no" ]] || [[ $ans == "NO" ]] || [[ $ans == "n" ]]; then
            exit
        else
            show_msg
        fi
        ;;
    $logout)
        ans=$(rdialog &)
        if [[ $ans == "yes" ]] || [[ $ans == "YES" ]] || [[ $ans == "y" ]]; then
            hyprctl dispatch exit
        elif [[ $ans == "no" ]] || [[ $ans == "NO" ]] || [[ $ans == "n" ]]; then
            exit
        else
            show_msg
        fi
        ;;
esac
