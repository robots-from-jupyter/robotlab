import sys
import os
import platform
from pathlib import Path

from ._version import __version__  # noqa


ROBOTLAB_PATH = Path(sys.prefix) / "share" / "jupyter" / "robotlab"

PLATFORM = platform.system().lower()
WIN = PLATFORM == "windows"
OSX = PLATFORM == "darwin"
SCRIPT_EXT = "bat" if WIN else "sh"
ICON_EXT = "icns" if OSX else "ico"
HERE = Path(__file__).parent
SCRIPTS = ["shell", "lab"]
BIN_DIR = str(
    Path(sys.prefix, *(["Scripts"] if WIN else ["bin"]))
)


def patch_app_dir(app_klass):
    app_klass.app_dir = os.environ["JUPYTERLAB_DIR"] = str(ROBOTLAB_PATH)
    return os.environ["JUPYTERLAB_DIR"]
