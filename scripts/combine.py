from . import TEST_OUT, run


def combine():
    args = [
        "python",
        "-m",
        "robot.rebot",
        "--name",
        "RobotLab",
        "--outputdir",
        str(TEST_OUT),
        "--output",
        "output.xml",
    ] + list(map(str, TEST_OUT.glob("*.robot.xml")))

    return run(args)


if __name__ == "__main__":
    combine()
