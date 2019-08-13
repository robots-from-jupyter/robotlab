import os
import subprocess
from pathlib import Path
import platform


PLATFORM = platform.system().lower()

SCRIPTS_DIR = Path(__file__).parent
SCRIPT_EXT = "bat" if platform == "windows" else "sh"
ROOT = SCRIPTS_DIR.parent

ARTIFACTS = ROOT / "_artifacts"
CACHE = ROOT / "_cache"

CONSTRUCT_DIR = ROOT / "constructor"

RECIPE_DIR = ROOT / "recipes"
CONDA_CACHE = CACHE / "conda-bld"

CONSTRUCT_CACHE = CACHE / "constructor"
CONSTRUCT = CONSTRUCT_DIR / "construct.yaml"

TEST_DIR = ROOT / "tests"

CONDA_OUT = ARTIFACTS / "conda-bld"
CONSTRUCT_OUT = ARTIFACTS / "constructor"
TEST_OUT = ARTIFACTS / "test_output"

ROBOTLAB_DIR = ROOT / "robotlab"

README = ROOT / "README.md"

# for easy overriding in CI
PY_MIN = os.environ.get("PY_MIN", "3.6")
PY_MAX = os.environ.get("PY_MAX", "3.7")
NODE_MIN = os.environ.get("NODE_MIN", "8")
NODE_MAX = os.environ.get("NODE_MAX", "9")
RF_VERSION = os.environ.get("ROBOTFRAMEWORK_VERSION", "3.1.2")
VERSION = os.environ.get("ROBOTLAB_VERSION", "1.0rc1")
CHROMEDRIVER_MIN = os.environ.get("CHROMEDRIVER_MIN", "74")
CHROMEDRIVER_MAX = os.environ.get("CHROMEDRIVER_MAX", "75")
IPYWIDGETS_VERSION = os.environ.get("IPYWIDGETS_VERSION", "7.4.2")


def run(args, **kwargs):
    """ Probably unneccessary "convenience" wrapper
    """
    p = subprocess.Popen(list(map(str, args)), **kwargs)

    try:
        p.wait()
    except KeyboardInterrupt as err:
        p.kill()
        raise err

    return p.returncode
