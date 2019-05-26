from pathlib import Path
import shutil
import sys

TUTORIAL_NAME = "robotkernel-tutorial"
TUTORIAL = Path(sys.prefix) / "var" / "www" / TUTORIAL_NAME


def copy_robotkernel_tutorial(dest=None):
    dest = Path(dest) if dest else Path(".")
    shutil.copytree(TUTORIAL, dest / TUTORIAL_NAME)
    return 0


if __name__ == "__main__":
    if len(sys.argv) > 1:
        dest = Path(sys.argv[1])
    else:
        dest = None
    sys.exit(copy_robotkernel_tutorial(dest))
