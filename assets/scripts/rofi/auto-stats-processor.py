import os
import re
import shutil
import subprocess
import sys
from datetime import datetime

stats_file = "/home/nox/Documents/garden/Extras/Temp Files/daily-stats.md"
stats_template = "/home/nox/Documents/garden/Extras/Templates/Temporal/stats.md"
stats_folder = "/home/nox/Documents/garden/Cards/Temporal/Stats/"


def error_send(error: str) -> None:
    subprocess.run(f'notify-send "{error}"', shell=True)
    sys.exit(error)


def end_with_number(text: str) -> bool:
    return bool(re.search(r"\d$", text))


def value_aggrigation(stat: str) -> str:
    if stat == "":
        return stat

    [heading, values] = stat.split("::", 1)

    if not end_with_number(values):
        return stat

    split_values = values.strip().split(" ")

    num_of_stats = max(1, len(split_values))
    total = round(sum([int(value) for value in split_values]) / num_of_stats)

    return f"{heading}:: {total}"


def cleanup_stats(lines: list[str]) -> list[str]:
    stats = [value_aggrigation(line) for line in lines]

    total = 0
    stat_without_numeric_value = 0
    for stat in stats:
        if end_with_number(stat):
            stat_value = stat.split("::")[1]
            total += int(stat_value)
        else:
            stat_without_numeric_value += 1

    overall_heading = "**overall**::"
    stats[
        stats.index(overall_heading)
    ] = f"{overall_heading} {round(total / (len(stats) - stat_without_numeric_value))}"

    return stats


def write_daily_stat(lines: list[str]) -> None:
    file_name = datetime.now().strftime("%Y-%m-%d-stats.md")
    with open(os.path.join(stats_folder, file_name), "w") as f:
        f.write("\n".join(lines).strip())


def main():
    # check if stats file exists
    if os.path.exists(stats_file):
        lines = []
        with open(stats_file) as f:
            lines = f.read().split("\n")

        cleaned_lines = cleanup_stats(lines)
        write_daily_stat(cleaned_lines)

    shutil.copy(stats_template, stats_file)


if __name__ == "__main__":
    main()
