"""
Perform a proper conda activate and launch robotlab

This only works if installed in a conda `root` environment
"""

import subprocess
import sys
import os
import signal
from pathlib import Path
from tempfile import TemporaryDirectory

from robotlab import WIN, BIN_DIR, SCRIPT_EXT

BAT_ACTIVATE = [
    f'call "{BIN_DIR}\\activate"  "{sys.prefix}"  || activate "{sys.prefix}"'
]

SH_ACTIVATE = [
    "#!" + "/usr/bin/env bash",
    f'. "{BIN_DIR}/activate" "{sys.prefix}" || . activate "{sys.prefix}"',
]

ACTIVATE = BAT_ACTIVATE if WIN else SH_ACTIVATE

BAT_CMD = ["call python -m robotlab.labapp"]

SH_CMD = ["python -m robotlab.labapp"]

CMD = BAT_CMD if WIN else SH_CMD


def launch_robotlab():
    with TemporaryDirectory() as td:
        tdp = Path(td)
        script = tdp / f"launch_robotlab.{SCRIPT_EXT}"
        lines = ACTIVATE + CMD
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
