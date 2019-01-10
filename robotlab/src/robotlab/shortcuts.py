import pyshortcuts
from . import HERE, SCRIPTS, SCRIPT_EXT, ICON_EXT, BIN_DIR


def make_shortcuts():
    for script in SCRIPTS:
        pyshortcuts.make_shortcut(
            # scripts created during build process
            script=str(BIN_DIR / f"launch_robotlab_{script}.{SCRIPT_EXT}"),
            name=script.title(),
            folder="RobotLab",
            icon=str(HERE / "icons" / f"{script}.{ICON_EXT}")
        )


if __name__ == "__main__":
    make_shortcuts()
