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


ACTIVATE = [
    f'''"{BIN_DIR}\\activate"  "{sys.prefix}"  || activate "{sys.prefix}"'''
] if WIN else [
    "#!" + "/usr/bin/env bash",
    f'''. "{BIN_DIR}/activate" "{sys.prefix}" || . activate "{sys.prefix}"'''
]


def launch_robotlab():
    with TemporaryDirectory() as td:
        tdp = Path(td)
        script = tdp / f"launch_robotlab.{SCRIPT_EXT}"
        lines = ACTIVATE + ["python -m robotlab.labapp"]
        script.write_text(os.linesep.join(lines))
        script.chmod(0o755)
        print(script.read_text(), "\n")
        proc = subprocess.Popen(
            [str(script)],
            cwd=os.path.expanduser("~"),
            preexec_fn=os.setsid
        )
        try:
            proc.wait()
        except KeyboardInterrupt:
            os.killpg(os.getpgid(proc.pid), signal.SIGTERM)


if __name__ == "__main__":
    launch_robotlab()
