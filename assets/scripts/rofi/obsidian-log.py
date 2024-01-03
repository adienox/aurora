#! /usr/bin/env python3

from io import TextIOWrapper
import subprocess
import sys
import shutil
import datetime

daily_folder = "/home/nox/Documents/Knowledge-Garden/Cards/Temporal/Daily/"
daily_template = (
    "/home/nox/Documents/Knowledge-Garden/Extras/Templates/Temporal/Daily.md"
)
daily_format = "yyyy-MM-dd"

# Define the shell command
command = 'rofi -dmenu -p "Log  " -mesg "<span color=\'#a6e3a1\'><i>Your future self will be proud of you for doing this today!</i></span>" -markup -theme-str "listview {enabled: false;}"'


def error_send(error: str) -> None:
    subprocess.run(f'notify-send "{error}"', shell=True)
    sys.exit(error)


def open_file(file: str) -> TextIOWrapper:
    try:
        data = open(file, "r+")
        return data
    except FileNotFoundError:
        shutil.copy(daily_template, file)
        data = open(file, "r+")
        return data
    except Exception as error:
        error_send(str(error))
        sys.exit()


def end_of_section(file: list, start_index: int) -> int:
    for index, line in enumerate(file[start_index + 1 :]):
        if not line.startswith("-"):
            return start_index + index + 1
    return -1


def add_to_log(log: str) -> None:
    # Getting date and time
    datetime_now = datetime.datetime.now()
    date = datetime_now.strftime("%Y-%m-%d.md")
    time = datetime_now.strftime("%H:%M")

    # opening, reading, and putting the file pointer at the start
    today_file = open_file(daily_folder + date)
    file_content = today_file.read().split("\n")
    today_file.seek(0)

    # figuring out the section start and end
    log_heading = file_content.index("# Log")
    end_of_log = end_of_section(file_content, log_heading)

    # error handling for section end
    if end_of_log == -1:
        error_msg = "End of section log cannot be found"
        error_send(error_msg)

    # writing the file content with new log
    file_content.insert(end_of_log, f"- **{time}** {log.strip()}")
    writable_file_content = "\n".join(file_content).strip()

    # writing the file content to file
    today_file.write(writable_file_content)
    today_file.truncate()
    today_file.close()


if __name__ == "__main__":
    # Run the command and capture the output
    log = subprocess.run(command, shell=True, capture_output=True, text=True)

    if not log.stdout.strip() == "":
        add_to_log(log.stdout.strip())
