#!/usr/bin/env python3

import json
import os
import re
import subprocess
import sys
import time
from datetime import datetime

date = datetime.today().strftime("%Y-%m-%d")
NOTE_DIR = "/home/nox/Documents/gardner/Sources/Media/"
METADATA_DIR = "/home/nox/.cache/obsidian/media/"


def read_file(file_path: str) -> str:
    with open(file_path, "r") as file:
        content = file.read()
    return content


def append_to_file(file_path: str, content: str) -> None:
    with open(file_path, "a") as file:
        file.write(content)


def write_to_file(file_path: str, content: str) -> None:
    with open(file_path, "w") as file:
        file.write(content)


def toggle_player() -> None:
    command = "playerctl play-pause"

    _ = subprocess.run(
        command, shell=True, capture_output=True, text=True
    ).stdout.strip()


def get_source() -> str:
    source = ""
    while True:
        clipboard = subprocess.run(
            "wl-paste", shell=True, capture_output=True, text=True
        ).stdout.strip()
        command = "notify-send 'copy url to clipboard'"
        _ = subprocess.run(
            command, shell=True, capture_output=True, text=True
        ).stdout.strip()
        pattern = r"\byoutu\.be\b"
        if bool(re.search(pattern, clipboard)):
            source = clipboard
            break
        time.sleep(3)
    return source.split("?")[0]


def get_highlight_url(source: str, position: str) -> str:
    position_split = position.split(":")
    if len(position_split) == 3:
        position = f"{position_split[0]}h{position_split[1]}m{position_split[2]}s"
    else:
        position = f"{position_split[0]}m{position_split[1]}s"

    return f"{source}?t={position}"


def get_player():
    command = 'playerctl -a metadata --format \'{"title": "{{title}}", "artist": "{{artist}}", "position": "{{duration(position)}}", "status": "{{status}}"}\''

    output = subprocess.run(
        command, shell=True, capture_output=True, text=True
    ).stdout.strip()

    return json.loads(output)


def get_title(title: str) -> str:
    theme_str = '-theme-str "listview {enabled: false;}"'
    message = f"-mesg \"<span color='#a6e3a1'><i>{title}</i></span>\" -markup"
    command = f'rofi -dmenu -p "Title  " {message} {theme_str} -filter "{title}"'

    output = subprocess.run(
        command, shell=True, capture_output=True, text=True
    ).stdout.strip()

    if output == "":
        toggle_player()
        sys.exit()

    return output


def get_note(title: str, source: str, position: str) -> str:
    theme_str = '-theme-str "listview {enabled: false;}"'
    message = f"-mesg \"<span color='#a6e3a1'><i>{title}</i></span>\" -markup"
    command = f'rofi -dmenu -p "Note  " {message} {theme_str}'

    output = subprocess.run(
        command, shell=True, capture_output=True, text=True
    ).stdout.strip()

    if output == "":
        toggle_player()
        sys.exit()

    highlight_url = get_highlight_url(source, position)

    return f"**Note**:: {output}\n\n[View Highlight]({highlight_url})\n\n---\n"


def sanitize_string(string: str) -> str:
    illegal_chars = ["<", ">", ":", '"', "/", "\\", "|", "?", "*", "#", "."]
    for char in illegal_chars:
        string = string.replace(char, "")  # Replace illegal characters with underscores
    return string


def create_metadata_note(data) -> None:
    path = METADATA_DIR + sanitize_string(data["title"]) + ".txt"
    source = get_source()
    title = get_title(sanitize_string(data["title"]))
    write_to_file(
        path,
        source + "\n" + sanitize_string(title) + "\n" + sanitize_string(data["artist"]),
    )


def create_note(data) -> None:
    [source, title, author] = read_file(
        METADATA_DIR + sanitize_string(data["title"]) + ".txt"
    ).split("\n")
    path = NOTE_DIR + title + ".md"
    note = get_note(title, source, data["position"])

    if os.path.exists(path):
        append_to_file(path, note)
    else:
        template = f"""---
title: {title}
tags:
  - note/🪨
author: "[[@{author}]]"
source:
  - {source}
created: {date}
---

## Highlights
{note}
"""
        write_to_file(path, template)


def main():
    data = get_player()
    if not data["status"] == "Playing":
        return
    toggle_player()

    metadata = METADATA_DIR + sanitize_string(data["title"]) + ".txt"

    if not os.path.exists(metadata):
        create_metadata_note(data)

    create_note(data)

    toggle_player()


if __name__ == "__main__":
    main()
