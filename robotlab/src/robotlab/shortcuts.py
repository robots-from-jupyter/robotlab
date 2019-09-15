import pyshortcuts.utils

from .paths import HERE, ICON_PATH


def make_shortcuts():
    script = str(HERE / "launch.py")
    name = "RobotLab"
    print("Making RobotLab shortcut in $HOME...")
    print("", pyshortcuts.utils.get_homedir())
    scut = pyshortcuts.make_shortcut(
        script=script,
        name=name,
        terminal=True,
        description="Launch RobotLab in Firefox in your $HOME",
        icon=ICON_PATH,
    )
    ""
    print("Shortcut created...")
    print("", scut)


if __name__ == "__main__":
    make_shortcuts()
