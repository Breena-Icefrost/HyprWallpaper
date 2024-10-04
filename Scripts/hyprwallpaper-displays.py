import subprocess

def screens():
    output = [l for l in subprocess.check_output(["xrandr"]).decode("utf-8").splitlines()]
    return [l.split()[0] for l in output if " connected " in l]

if __name__ == "__main__":
    displays = screens()
    for display in displays:
        print(display)