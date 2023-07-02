#! /bin/python3

from pynput import keyboard # For keyboard listen event
import os # For running system commands
import sys # For exiting the process


# Keypress event
def onPress(key):
    # Checks if key is key.ctrl_r
    if key == keyboard.Key.ctrl_r:
        # Unmutes the microphone
        os.system('pactl set-source-mute @DEFAULT_SOURCE@ false')

# Key release event
def onRelease(key):
    # Checks if key is key.ctrl_r
    if key == keyboard.Key.ctrl_r:
        # Mutes the microphone
        os.system('pactl set-source-mute @DEFAULT_SOURCE@ true')

def revertBack():
    print('Reverting back...')
    os.system('notify-send "Microphone" "Reverting back..."')
    os.system('pactl set-source-mute @DEFAULT_SOURCE@ false')
    print('Goodbye!')

file = os.path.expanduser("~/.cache/is-active-mic")
if os.access(file, os.F_OK):
    #if the lockfile is already there then check the PID number
    #in the lock file
    pidfile = open(file, "r")
    pidfile.seek(0)
    old_pid = pidfile.readline()
    # Now we check the PID from lock file matches to the current
    # process PID
    if os.path.exists("/proc/%s" % old_pid):
        # Sets the microphone to unmute
        revertBack()
        # Killing the process
        os.system(f'kill {old_pid}')
        os.remove(file)
        sys.exit(1)
    else:
        # Removing the pid file if the file is present but the program is not running
        os.remove(file)

pidfile = open(file, "w")
pidfile.write("%s" % os.getpid())
pidfile.close()

try:
    # Set the microphone to mute by default
    print('Setting source to mute by default...')
    os.system('notify-send "Microphone" "Setting source to mute by default..."')
    os.system('pactl set-source-mute @DEFAULT_SOURCE@ true')

    # Listen for key events
    with keyboard.Listener(on_press=onPress, on_release=onRelease) as listener:
        listener.join()

except:
    # Sets the microphone to unmute
    revertBack()
    sys.exit()
