from pathlib import Path
import shutil
import sys

from .paths import TUTORIAL_NAME, TUTORIAL


def copy_robotkernel_tutorial(dest=None):
    dest = (Path(dest) if dest else Path(".")).resolve()
    shutil.copytree(TUTORIAL, dest / TUTORIAL_NAME)
    if not dest.exists():
        dest.mkdir(parents=True)
    print("\n".join(map(str, (dest / TUTORIAL_NAME).glob("*"))))
    return 0


if __name__ == "__main__":
    dest = Path(sys.argv(1)) if len(sys.argv) > 1 else None
    sys.exit(copy_robotkernel_tutorial(dest))
