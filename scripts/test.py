from . import run, TEST_DIR, TEST_OUT, PLATFORM
import sys


def run_tests(robot_args):
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
    sys.exit(run_tests(sys.argv[1:]))
