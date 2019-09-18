""" Paths

    These will probably only work with the like-versioned RobotLab distribution
"""
from pathlib import Path
import sys

import platform

HERE = Path(__file__).parent

PREFIX = Path(sys.prefix).resolve()
PYTHON_EXE = Path(sys.executable)

ROBOTLAB_PATH = PREFIX / "share" / "jupyter" / "robotlab"

PLATFORM = platform.system().lower()
WIN = PLATFORM == "windows"
OSX = PLATFORM == "darwin"
SCRIPT_EXT = "bat" if WIN else "sh"

ICON_EXT = "icns" if OSX else "ico"
ICON_PATH = str(HERE / "icons" / f"lab.{ICON_EXT}")

BIN_DIR = Path(sys.prefix, *(["Scripts"] if WIN else ["bin"]))

BAT_ACTIVATE = [
    f'call "{BIN_DIR}\\activate.bat" "{PREFIX}" || call activate "{PREFIX}"'
]

SH_ACTIVATE = [
    "#!" + "/usr/bin/env bash",
    f'. "{BIN_DIR}/activate" "{PREFIX}" || . activate "{PREFIX}"',
]

ACTIVATE = BAT_ACTIVATE if WIN else SH_ACTIVATE
BROWSER = f"--browser=firefox"

LAUNCH_CMD = f"python -m robotlab.labapp {BROWSER}"
LAUNCH_SCRIPT = f"launch_robotlab.{SCRIPT_EXT}"

TUTORIAL_NAME = "robotkernel-tutorial"
TUTORIAL = PREFIX / "var" / "www" / TUTORIAL_NAME

EXAMPLES_NAME = "robotkernel-examples"
EXAMPLES = PREFIX / "var" / "www" / EXAMPLES_NAME
