"""
Author  - Breena Icefrost
Date    - 2024-10-04
Version - 0.6
"""

import subprocess

# Define the command as a list of strings
command = ['hyprctl', 'monitors']

def screens():
    output = [l for l in subprocess.check_output(command).decode("utf-8").splitlines()]
    return [l.split()[1] for l in output if "Monitor " in l]

if __name__ == "__main__":
    displays = screens()
    for display in displays:
        print(display)
    print("ALL")
