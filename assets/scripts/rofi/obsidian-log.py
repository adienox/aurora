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

gratitudes = ["grateful", "kudos", "appreciate"]
meals = ["breakfast", "lunch", "dinner", "meal", "snacks"]
workouts = ["gym", "exercise", "workout", "pushups"]


def check_keywords(text: str, keywords: list[str]) -> bool:
    """
    Checks if certains keywords are present in the text.
    The keywords to check are passed in to the function.
    """
    return any(string in text for string in keywords)


def error_send(error: str) -> None:
    """
    Used to send error message to the user via shell and notification.
    """
    subprocess.run(f'notify-send "{error}"', shell=True)
    sys.exit(error)


def open_file(file: str, template: str) -> TextIOWrapper:
    """
    This is a function to open the file in append mode.
    If the file doesn't exist, create it using the template.
    """
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
    """
    append the log to the end of journal.
    """
    # Getting date and time
    datetime_now = datetime.datetime.now()
    file = datetime_now.strftime("%Y-%m-%d.md")
    time = datetime_now.strftime("%H:%M")

    # opening the file or creating the file using template
    today_file = open_file(os.path.join(daily_folder + file), daily_template)

    # assigning the list type based of what keywords the log has
    if check_keywords(log, gratitudes):
        list_type = "- [g]"
    elif check_keywords(log, meals):
        list_type = "- [m]"
    elif check_keywords(log, workouts):
        list_type = "- [w]"
    else:
        list_type = "-"

    writable_log = f"\n{list_type} **{time}** {log}"

    # appending the log to the file
    today_file.write(writable_log)
    today_file.close()


if __name__ == "__main__":
    # Run the command and capture the output
    log = subprocess.run(
        command, shell=True, capture_output=True, text=True
    ).stdout.strip()

    if not log == "":
        add_to_log(log)
