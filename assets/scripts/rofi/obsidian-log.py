#! /usr/bin/env python3

import datetime
import os
import shutil
import subprocess
import sys
from io import TextIOWrapper

daily_folder = "/home/nox/Documents/garden/Cards/Temporal/Daily/"
daily_template = "/home/nox/Documents/garden/Extras/Templates/Temporal/daily.md"

# Define the shell command
command = 'rofi -dmenu -p "Log  " -mesg "<span color=\'#a6e3a1\'><i>Your future self will be proud of you for doing this today!</i></span>" -markup -theme-str "listview {enabled: false;}"'


def error_send(error: str) -> None:
    subprocess.run(f'notify-send "{error}"', shell=True)
    sys.exit(error)


def open_file(file: str, template: str) -> TextIOWrapper:
    try:
        data = open(file, "a")
        return data
    except FileNotFoundError:
        shutil.copy(template, file)
        data = open(file, "a")
        return data
    except Exception as error:
        error_send(str(error))
        sys.exit()


def add_to_log(log: str) -> None:
    # Getting date and time
    datetime_now = datetime.datetime.now()
    file = datetime_now.strftime("%Y-%m-%d.md")
    time = datetime_now.strftime("%H:%M")

    today_file = open_file(os.path.join(daily_folder + file), daily_template)

    # writing the file content with new log
    writable_log = f"\n- **{time}** {log}"

    # writing the file content to file
    today_file.write(writable_log)
    today_file.close()


if __name__ == "__main__":
    # Run the command and capture the output
    log = subprocess.run(
        command, shell=True, capture_output=True, text=True
    ).stdout.strip()

    if not log == "":
        add_to_log(log)
