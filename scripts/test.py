from . import run, TEST_DIR, TEST_OUT
import sys


def test():
    return run([
        sys.executable, "-m", "robot",
        "--outputdir", str(TEST_OUT),
        str(TEST_DIR)
    ])


if __name__ == "__main__":
    sys.exit(test())
