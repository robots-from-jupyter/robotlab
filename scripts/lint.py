import sys
from . import ROOT, run


def black():
    return run(
        ["black", "-l79", str(ROOT / "robotlab"), str(ROOT / "scripts")]
    )


def tidy():
    return run(
        [sys.executable, "-m", "robot.tidy", "--inplace"]
        + list(map(str, (ROOT / "tests").rglob("*.robot")))
    )


if __name__ == "__main__":
    assert not black() and not tidy()
    sys.exit(0)
