from pathlib import Path
import sys
from . import SCRIPT_EXT, BIN_DIR, SCRIPTS, WIN


if WIN:
    ACTIVATE = f"""{BIN_DIR}\\activate {sys.prefix}"""
else:
    ACTIVATE = f"""#!/usr/bin/env bash
. {BIN_DIR}/activate {sys.prefix}"""


def make_scripts():
    for script in SCRIPTS:
        script_path = Path(BIN_DIR, f"launch_robotlab_{script}.{SCRIPT_EXT}")
        lines = [ACTIVATE, ("robotlab" if script == "lab" else "")]
        script_path.write_text("\n".join(lines))


if __name__ == "__main__":
    make_scripts()
