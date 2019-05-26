from pathlib import Path
import shutil
import sys

EXAMPLES_NAME = "robotkernel-examples"
EXAMPLES = Path(sys.prefix) / "var" / "www" / EXAMPLES_NAME


def copy_robotkernel_examples(dest=None):
    dest = Path(dest) if dest else Path(".")
    shutil.copytree(EXAMPLES, dest / EXAMPLES_NAME)
    return 0


if __name__ == "__main__":
    if len(sys.argv) > 1:
        dest = Path(sys.argv[1])
    else:
        dest = None
    sys.exit(copy_robotkernel_examples(dest))
