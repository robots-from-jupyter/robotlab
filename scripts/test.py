import sys
import os

from . import run, TEST_DIR, TEST_OUT, PLATFORM


def run_tests(robot_args, headless=False):
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
        ]
        + list(robot_args or [])
        + [str(TEST_DIR)]
    )
    return run(args)


if __name__ == "__main__":
    headless = False
    args = sys.argv[1:]

    if "--headless" in args:
        headless = True
        args.remove("--headless")

    sys.exit(run_tests(args, headless=headless))
