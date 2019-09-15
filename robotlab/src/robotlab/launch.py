"""
Perform a proper conda activate and launch robotlab

This only works if installed in a conda `root` environment
"""

import subprocess
import os
import signal
from pathlib import Path
from tempfile import TemporaryDirectory

from .paths import ACTIVATE, LAUNCH_CMD, LAUNCH_SCRIPT


def launch_robotlab():
    with TemporaryDirectory() as td:
        tdp = Path(td)
        script = tdp / LAUNCH_SCRIPT
        lines = ACTIVATE + LAUNCH_CMD
        script.write_text(os.linesep.join(lines))
        script.chmod(0o755)
        print(script.read_text(), "\n")
        proc = subprocess.Popen([str(script)], cwd=os.path.expanduser("~"))
        try:
            proc.wait()
        except KeyboardInterrupt:
            os.killpg(os.getpgid(proc.pid), signal.SIGTERM)


if __name__ == "__main__":
    launch_robotlab()
