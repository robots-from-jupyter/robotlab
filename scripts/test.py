import shutil
import sys

import chromedriver_binary  # noqa

from . import run, TEST_DIR, TEST_OUT, PLATFORM


def run_tests(robot_args):
    out = TEST_OUT / PLATFORM
    if out.exists():
        shutil.rmtree(out)
    out.mkdir(parents=True)
    args = (
        [
            sys.executable,
            "-m",
            "robot",
            "--name",
            PLATFORM,
            "--outputdir",
            TEST_OUT / PLATFORM,
            "--output",
            TEST_OUT / f"{PLATFORM}.robot.xml",
            "--log",
            TEST_OUT / f"{PLATFORM}.log.html",
            "--report",
            TEST_OUT / f"{PLATFORM}.report.html",
            "--xunit",
            TEST_OUT / f"{PLATFORM}.xunit.xml",
            "--variable",
            f"OS:{PLATFORM}",
        ]
        + list(robot_args or [])
        + [TEST_DIR]
    )
    return run(args)


if __name__ == "__main__":
    sys.exit(run_tests(sys.argv[1:]))
