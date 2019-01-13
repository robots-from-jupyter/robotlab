import pyshortcuts

from . import HERE, ICON_EXT


def make_shortcuts():
    script = str(HERE / "launch.py")
    print("Making shortcut to", script)
    pyshortcuts.make_shortcut(
        script=script,
        name="RobotLab",
        terminal=True,
        description="Launch RobotLab in your $HOME",
        icon=str(HERE / "icons" / f"lab.{ICON_EXT}")
    )


if __name__ == "__main__":
    make_shortcuts()
