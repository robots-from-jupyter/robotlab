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

TEST_DIR = ROOT / "tests"

CONDA_OUT = ARTIFACTS / "conda-bld"
CONSTRUCT_OUT = ARTIFACTS / "constructor"
TEST_OUT = ARTIFACTS / "test_output"
LAB_OUT = ARTIFACTS / "app_dir"

ROBOTLAB_DIR = ROOT / "robotlab"
README = ROOT / "README.md"

# for easy overriding in CI
VERSION = os.environ.get("ROBOTLAB_VERSION", "2020.01.0")
CONDA_VERSION = os.environ.get("CONDA_VERSION", "4.7.12")
RF_VERSION = os.environ.get("RF_VERSION", "3.1.2")
PY_MAX = os.environ.get("PY_MAX", "3.7.0a0")
PY_MIN = os.environ.get("PY_MIN", "3.6")
LABEXTENSIONS = os.environ.get(
    "LABEXTENSIONS",
    """
@deathbeds/jupyterlab-starters@0.1.0a2
@jupyter-widgets/jupyterlab-manager@1.1.0
@jupyterlab/toc@1.0.1
jupyterlab_robotmode@2.4.0
jupyterlab-jupytext@1.1.0
""".replace(
        "\n", " "
    ),
).split()

CONDA_BUILD_ARGS = [
    "conda-build",
    "--output-folder",
    CONDA_OUT,
    "--cache-dir",
    CONDA_CACHE,
    "-c",
    "https://conda.anaconda.org/anaconda",
    "-c",
    "https://conda.anaconda.org/conda-forge",
    "--python",
    PY_MIN,
]

CONSTRUCTOR_ARGS = [
    "constructor",
    "--verbose",
    "--cache-dir",
    str(CONSTRUCT_CACHE),
    "--output-dir",
    str(CONSTRUCT_OUT),
]


def run(args, **kwargs):
    """ Probably unneccessary "convenience" wrapper
    """
    str_args = list(map(str, args))
    print("===\n", " ".join(str_args), "\n===")
    p = subprocess.Popen(str_args, **kwargs)

    try:
        p.wait()
    except KeyboardInterrupt as err:
        p.kill()
        p.wait()
        raise err

    return p.returncode
