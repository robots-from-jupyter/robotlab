from . import run, TEST_DIR, TEST_OUT
import sys
import platform

import chromedriver_binary  # noqa


def test():
    return run(
        [
            sys.executable,
            "-m",
            "robot",
            "--outputdir",
            str(TEST_OUT / platform.system()),
            "--xunit",
            "robot.xunit.xml",
            str(TEST_DIR),
        ]
    )


if __name__ == "__main__":
    sys.exit(test())
