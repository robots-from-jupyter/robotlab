import sys
from . import SCRIPT_EXT, BIN_DIR, SCRIPTS, WIN


if WIN:
    ACTIVATE = f"""
"{BIN_DIR}\\activate"  "{sys.prefix}" || activate "{sys.prefix}"
"""
else:
    ACTIVATE = f"""#!/usr/bin/env bash
set -ex
. "{BIN_DIR}/activate" "{sys.prefix}" \
|| . activate "{sys.prefix}"
${{SHELL}}
conda info
"""


def make_scripts():
    for script in SCRIPTS:
        script_path = BIN_DIR / f"launch_robotlab_{script}.{SCRIPT_EXT}"
        lines = [ACTIVATE, ("robotlab" if script == "lab" else "")]
        print(f"Writing RobotLab shortcut {script} \n- to {script_path}")
        script_path.write_text("\n".join(lines))
        print(f"- and executable")
        script_path.chmod(0o755)


if __name__ == "__main__":
    make_scripts()
