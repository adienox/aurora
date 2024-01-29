#! /usr/bin/env python3
import os
import random
import shutil
import subprocess
from datetime import datetime

stats_file = "/home/nox/Documents/garden/Extras/Temp Files/daily-stats.md"
stats_template = "/home/nox/Documents/garden/Extras/Templates/Temporal/stats.md"

# List of stats to ask and questions associated with them in dict
stats = {
    "mindfulness": "How mindful are you?",
    "positivity": "How positive do you feel?",
    "health": "How healthy do you feel?",
    "energy": "How much energy do you have?",
    "sociability": "How social are you?",
    "productivity": "How productive are you?",
    "discipline": "Are you doing what you are supposed to?",
    "mood": "How good do you feel?",
    "uniqueness": "How unique is the current moment?",
    "amazing": "Why are you amazing?",
}


def get_command(key: str, message: str, **kwargs) -> str:
    theme_str = '-theme-str "listview {enabled: false;}"'
    command = f'rofi -dmenu -p "{key.title()}  " -mesg "<span color=\'#a6e3a1\'><i>{message}</i></span>" -markup {theme_str}'
    pre_fill = kwargs.get("pre_fill", None)
    if pre_fill:
        return command + f' -filter "{pre_fill} "'
    else:
        return command


def select_key() -> str:
    with open(stats_file) as f:
        stats_keys = list(stats.keys())[:-1]
        lines = f.read().split("\n")[: len(stats_keys)]
        f.seek(0)

        items_per_stat = [len(line.split(" ")) - 1 for line in lines]

        stat_to_choose = items_per_stat.index(min(items_per_stat))

        return stats_keys[stat_to_choose]


def check_stat_filled(stat_name: str) -> bool:
    with open(stats_file) as f:
        file_content = f.read().split("\n")
        try:
            stat_line = file_content.index(f"**{stat_name}**::")
        except ValueError:
            return True
        stat = file_content[stat_line]
        f.seek(0)
        return len(stat) > 15


def get_stat_value(key: str) -> int:
    # use rofi to get the stat
    message = stats[key]
    command = get_command(key, message)

    while True:
        try:
            log = int(
                subprocess.run(
                    command, shell=True, capture_output=True, text=True
                ).stdout.strip()
            )
        except ValueError:
            continue

        if 0 <= log <= 5:
            break

    return log


def update_stat(key: str, value: int | str):
    # write down the stat in a file
    with open(stats_file, "r+") as f:
        lines = f.read().split("\n")
        f.seek(0)

        lines = [
            line + f" {value}" if line.startswith(f"**{key}**") else line
            for line in lines
        ]

        f.write("\n".join(lines).strip())
        f.truncate()


def get_amazing_value() -> str:
    # use rofi to get the stat
    key = "amazing"
    message = stats[key]
    command = get_command(key, message, pre_fill="I'm amazing because")

    while True:
        try:
            log = subprocess.run(
                command, shell=True, capture_output=True, text=True
            ).stdout.strip()
        except ValueError:
            continue

        if len(log) > 25:
            break

    return log


def main():
    # check if stats file exists
    if not os.path.exists(stats_file):
        shutil.copy2(stats_template, stats_file)

    current_time = datetime.now().hour

    amazing_filled = check_stat_filled("amazing")
    workout_filled = check_stat_filled("Exercise")

    if not workout_filled:
        selected_key = "Exercise"
        # value = get_workout_value()

    # increasing the chance to ask the auto stat as day proceeds
    chance = random.choice(range(1, 22 - current_time))
    if not amazing_filled and chance == 1:
        selected_key = "amazing"
        value = get_amazing_value()
    else:
        selected_key = select_key()
        value = get_stat_value(selected_key)
    update_stat(selected_key, value)


if __name__ == "__main__":
    main()
