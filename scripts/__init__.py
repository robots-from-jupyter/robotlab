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
VERSION = os.environ.get("ROBOTLAB_VERSION", "2019.9.0")
FIREFOX_VERSION = os.environ.get("FIREFOX_VERSION", "68.0.2")
IPYWIDGETS_VERSION = os.environ.get("IPYWIDGETS_VERSION", "7.5.1")
NODE_MAX = os.environ.get("NODE_MAX", "12")
NODE_MIN = os.environ.get("NODE_MIN", "11")
PY_MAX = os.environ.get("PY_MAX", "3.8.0a0")
PY_MIN = os.environ.get("PY_MIN", "3.7")
RF_VERSION = os.environ.get("ROBOTFRAMEWORK_VERSION", "3.1.2")
RK_VERSION = os.environ.get("ROBOTKERNEL_VERSION", "1.0")


def run(args, **kwargs):
    """ Probably unneccessary "convenience" wrapper
    """
    p = subprocess.Popen(list(map(str, args)), **kwargs)

    try:
        p.wait()
    except KeyboardInterrupt as err:
        p.kill()
        p.wait()
        raise err

    return p.returncode
