import sys
from . import ROOT, run


PY_SRC = [str(ROOT / "robotlab"), str(ROOT / "scripts")]
RF_SRC = list(map(str, (ROOT / "tests").rglob("*.robot")))


def black():
    return run(["black", "-l79"] + PY_SRC)


def tidy():
    return run([sys.executable, "-m", "robot.tidy", "--inplace"] + RF_SRC)


def flake8():
    return run(["flake8", "--ignore", "E203,W503"] + PY_SRC)


def rflint():
    return run(
        [
            "rflint",
            "--configure",
            "TooManyTestSteps:20",
            "--configure",
            "TooFewTestSteps:0",
            "--configure",
            "TooFewKeywordSteps:0",
            "--configure",
            "LineTooLong:200",
        ]
        + RF_SRC
    )


if __name__ == "__main__":
    assert not black() and not tidy() and not flake8() and not rflint()
    sys.exit(0)
