import os
import shutil
import subprocess
import sys
from datetime import datetime
from io import TextIOWrapper

stats_file = "/home/nox/Documents/Knowledge-Garden/Extras/stats.md"
stats_template = (
    "/home/nox/Documents/Knowledge-Garden/Extras/Templates/stats-template.md"
)
daily_folder = "/home/nox/Documents/Knowledge-Garden/Cards/Temporal/Daily/"
daily_template = (
    "/home/nox/Documents/Knowledge-Garden/Extras/Templates/Temporal/Daily.md"
)


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


def cleanup(stat: str) -> str:
    data = stat.split(" ")
    num_of_stats = max(1, len(data) - 1)
    total = round(sum([int(d) for d in data[1:]]) / num_of_stats)

    return f"{data[0]} {total}"


def update_daily_note(stats: list[str]):
    # Getting date
    date = datetime.now().strftime("%Y-%m-%d.md")

    # opening, reading, and putting the file pointer at the start
    today_file = open_file(daily_folder + date)
    file_content = today_file.read().split("\n")
    today_file.seek(0)

    total = 0
    for stat in stats:
        [stat_heading, stat_value] = stat.split(" ")
        total += int(stat_value)
        stat_heading_index = file_content.index(stat_heading)
        file_content[stat_heading_index] = stat

    overall_heading = "**overall**::"
    file_content[
        file_content.index(overall_heading)
    ] = f"{overall_heading} {round(total / len(stats))}"

    writable_file_content = "\n".join(file_content).strip()

    # writing the file content to file
    today_file.write(writable_file_content)
    today_file.truncate()
    today_file.close()


def main():
    # check if stats file exists
    if os.path.exists(stats_file):
        with open(stats_file) as f:
            lines = f.read().split("\n")
            lines = [cleanup(line) for line in lines]

            update_daily_note(lines)

    shutil.copy(stats_template, stats_file)


if __name__ == "__main__":
    main()
