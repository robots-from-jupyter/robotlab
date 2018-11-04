from . import run, TEST_DIR, TEST_OUT
import sys
import platform


def test():
    return run([
        sys.executable, "-m", "robot",
        "--outputdir", str(TEST_OUT / platform.system()),
        str(TEST_DIR)
    ])


if __name__ == "__main__":
    sys.exit(test())
