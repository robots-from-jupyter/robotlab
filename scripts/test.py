import sys
import os

from . import run, TEST_DIR, TEST_OUT, PLATFORM, CONDA_OUT, CONDA_BUILD_ARGS


def test_conda(packages=None):
    rc = 0
    packages = packages or sorted(
        [
            pkg
            for pkg in CONDA_OUT.glob("*/*.tar.bz2")
            if "repodata" not in pkg.name
        ]
    )
    for pkg in packages:
        rc = rc or run([*CONDA_BUILD_ARGS, "--test", pkg])
    return rc


def test_robot(robot_args=None, headless=False, in_robotlab=False):
    if headless:
        os.environ["MOZ_HEADLESS"] = "1"

    args = (
        [
            sys.executable,
            "-m",
            "robot",
            "--name",
            PLATFORM,
            "--outputdir",
            str(TEST_OUT),
            "--output",
            f"{PLATFORM}.robot.xml",
            "--log",
            f"{PLATFORM}.log.html",
            "--report",
            f"{PLATFORM}.report.html",
            "--xunit",
            f"{PLATFORM}.xunit.xml",
            "--variable",
            f"OS:{PLATFORM}",
            "--variable",
            f"IN_ROBOTLAB:{int(in_robotlab)}",
        ]
        + list(robot_args or [])
        + [str(TEST_DIR)]
    )
    return run(args)


if __name__ == "__main__":
    rc = 0
    headless = in_robotlab = False

    args = sys.argv[1:]

    if "--headless" in args:
        headless = True
        args.remove("--headless")

    if "--in-robotlab" in args:
        in_robotlab = True
        args.remove("--in-robotlab")

    if not args:
        rc = test_conda()
        rc = rc or test_robot(headless=headless, in_robotlab=in_robotlab)
    else:
        it, rest = args[0], args[1:]

        if it == "conda":
            rc = test_conda(rest)
        elif it == "robot":
            rc = test_robot(rest, headless=headless, in_robotlab=in_robotlab)

    sys.exit(rc)
