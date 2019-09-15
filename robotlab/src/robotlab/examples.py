from pathlib import Path
import shutil
import sys

from .paths import EXAMPLES, EXAMPLES_NAME


def copy_robotkernel_examples(dest=None):
    dest = Path(dest) if dest else Path(".")
    shutil.copytree(EXAMPLES, dest / EXAMPLES_NAME)
    return 0


if __name__ == "__main__":
    dest = Path(sys.argv(1)) if len(sys.argv) > 1 else None
    sys.exit(copy_robotkernel_examples(dest))
