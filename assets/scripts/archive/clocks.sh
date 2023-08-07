#! /bin/sh

menu() {
    printf "1. Clock\n"
    printf "2. Timer\n"
}

main() {
    choice=$(menu | rofi -dmenu -theme generic -kb-row-up k -kb-row-down j -kb-accept-entry l,Return -kb-cancel h,Escape | cut -d. -f1)

    case $choice in
        1)
            #https://github.com/joshdk/tty-qlock
            alacritty -o font.size=18 -e ~/.local/bin/qlock
            break
            ;;
        2)
            alacritty --class timer,floating -t timer -e ~/.config/scripts/timer.sh
            break
            ;;
    esac
}

main
