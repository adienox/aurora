#! /usr/bin/env python3
import os
import shutil
import subprocess

stats_file = "/home/nox/Documents/Knowledge-Garden/Extras/stats.md"
stats_template = "/home/nox/Documents/Knowledge-Garden/Extras/Templates/stats.md"

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
}


def select_key() -> str:
    with open(stats_file) as f:
        lines = f.read().split("\n")
        f.seek(0)

        items_per_stat = [len(line.split(" ")) - 1 for line in lines]

        stats_keys = list(stats.keys())

        stat_to_choose = items_per_stat.index(min(items_per_stat))

        return stats_keys[stat_to_choose]


def get_stat_value(key: str) -> int:
    # use rofi to get the stat
    message = stats[key]
    theme_str = '-theme-str "listview {enabled: false;}"'
    command = f'rofi -dmenu -p "{key.title()}  " -mesg "<span color=\'#a6e3a1\'><i>{message}</i></span>" -markup {theme_str}'

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


def update_stat(key: str, value: int):
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


def main():
    # check if stats file exists
    if not os.path.exists(stats_file):
        shutil.copy2(stats_template, stats_file)

    selected_key = select_key()

    value = get_stat_value(selected_key)

    update_stat(selected_key, value)


if __name__ == "__main__":
    main()
