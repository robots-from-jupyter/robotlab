import os
import subprocess
from pathlib import Path
import platform


PLATFORM = platform.system().lower()

SCRIPTS_DIR = Path(__file__).parent
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
RF_VERSION = os.environ.get("ROBOTFRAMEWORK_VERSION", "3.1.1")
VERSION = os.environ.get("ROBOTLAB_VERSION", "0.10.0")
CHROMEDRIVER_VERSION = os.environ.get("CHROMEDRIVER_VERSION", "2.45")
IPYWIDGETS_VERSION = os.environ.get("CHROMEDRIVER_VERSION", "7.4.2")

POST_INSTALL = dict(
    linux="post_install.linux.sh",
    darwin="post_install.darwin.sh",
    windows="post_install.windows.bat",
)


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
