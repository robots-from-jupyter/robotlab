"""
Perform a proper conda activate and launch robotlab
"""

import subprocess
import os
import sys
import signal
from pathlib import Path
from tempfile import TemporaryDirectory

from robotlab.paths import ACTIVATE, LAUNCH_CMD, LAUNCH_SCRIPT


def launch_robotlab(lab_args=None):
    lab_cmd = " ".join([LAUNCH_CMD] + (lab_args or []))

    with TemporaryDirectory() as td:
        tdp = Path(td)
        script = tdp / LAUNCH_SCRIPT
        lines = ACTIVATE + [lab_cmd]
        script.write_text(os.linesep.join(lines))
        script.chmod(0o755)
        print("Launching RobotLab")
        print(script.read_text(), "\n")
        proc = subprocess.Popen([str(script)], cwd=os.path.expanduser("~"))
        try:
            proc.wait()
        except KeyboardInterrupt:
            os.killpg(os.getpgid(proc.pid), signal.SIGTERM)


if __name__ == "__main__":
    launch_robotlab(sys.argv[1:])
