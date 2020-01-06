from pathlib import Path
import os, sys, shutil, json

SRC_DIR = Path(os.environ["SRC_DIR"])
PREFIX = Path(os.environ["PREFIX"])

APP = SRC_DIR / "app_dir"

WWW = PREFIX / "var" / "www"
ETC = PREFIX / "etc" / "jupyter" / "jupyter_notebook_config.d"
SHARE = PREFIX / "share" / "jupyter"

KERNEL = SRC_DIR / "robotkernel"
EXAMPLES = WWW / "robotkernel-examples"
TUTORIAL = WWW / "robotkernel-tutorial"
NOTEBOOKS = {
    EXAMPLES: KERNEL / "examples",
    TUTORIAL: KERNEL / "docs" / "notebooks"
}
SVG = SRC_DIR / "robotlab" / "src" / "robotlab" / "icons" / "starter.svg"

print("making directories...")
[d.mkdir(exist_ok=True, parents=True) for d in [SHARE, ETC, WWW]]

print("copying lab...")
shutil.rmtree(APP / "staging", ignore_errors=True)
shutil.copytree(APP, SHARE / "robotlab")

print("copying notebooks...")
NOT_A_NOTEBOOK = lambda d, paths: [p for p in paths if not p.endswith(".ipynb")]
[
    shutil.copytree(src, dest, ignore=NOT_A_NOTEBOOK)
    for dest, src in NOTEBOOKS.items()
]

# RobotKernel packages its starters since 1.3rc1

#print("making starters...")
#(ETC / "robotlab-starters.json").write_text(json.dumps({
#    "StarterManager": {
#        "extra_starters": {
#            "robotkernel-examples": {
#                "type": "copy",
#                "label": "Robotkernel Examples",
#                "description": "Examples of using robotkernel",
#                "icon": SVG.read_text().replace("jp-icon3", "jp-icon-contrast1"),
#                "src": str(EXAMPLES)
#            },
#            "robotkernel-tutorial": {
#                "type": "copy",
#                "label": "Robotkernel Tutorial",
#                "description": "A guided tutorial through using robotkernel",
#                "icon": SVG.read_text().replace("jp-icon3", "jp-icon-contrast3"),
#                "src": str(TUTORIAL)
#            }
#        }
#    }
#}, indent=2))
