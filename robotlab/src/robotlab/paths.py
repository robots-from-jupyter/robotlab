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

FIREFOXEN = {
    "windows": PREFIX / "Library" / "bin" / "firefox.exe",
    **{unix: PREFIX / "bin" / "firefox" for unix in ["linux", "darwin"]},
}

FIREFOX = FIREFOXEN[PLATFORM]


BAT_ACTIVATE = [
    f'call "{BIN_DIR}\\activate"  "{PREFIX}"  || activate "{PREFIX}"'
]

SH_ACTIVATE = [
    "#!" + "/usr/bin/env bash",
    f'. "{BIN_DIR}/activate" "{PREFIX}" || . activate "{PREFIX}"',
]

ACTIVATE = BAT_ACTIVATE if WIN else SH_ACTIVATE
BROWSER = f"--browser='{FIREFOX}'"

BAT_LAUNCH_CMD = [f"call '{PYTHON_EXE}' -m robotlab.labapp {BROWSER}"]

SH_LAUNCH_CMD = [f"'{PYTHON_EXE}' -m robotlab.labapp {BROWSER}"]

LAUNCH_CMD = BAT_LAUNCH_CMD if WIN else SH_LAUNCH_CMD
LAUNCH_SCRIPT = f"launch_robotlab.{SCRIPT_EXT}"

TUTORIAL_NAME = "robotkernel-tutorial"
TUTORIAL = PREFIX / "var" / "www" / TUTORIAL_NAME

EXAMPLES_NAME = "robotkernel-examples"
EXAMPLES = PREFIX / "var" / "www" / EXAMPLES_NAME
