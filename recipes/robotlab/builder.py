from pathlib import Path
import os, sys, shutil, json, platform, re

PLATFORM = platform.system().lower()

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
    TUTORIAL: KERNEL / "src" / "robotkernel" / "resources" / "notebooks" / "tutorial"
}
SVG = SRC_DIR / "robotlab" / "src" / "robotlab" / "icons" / "starter.svg"

OPENCV_OSX = """
    ${prefix} =     Evaluate   __import__("sys").prefix
    Create WebDriver    Firefox    headless=True    executable_path=${prefix}${/}bin${/}geckodriver    firefox_binary=${prefix}${/}bin${/}geckodriver
    Go To   https://www.google.com/?hl=en
"""


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

print("hacking OpenCV Notebook on OSX")

if PLATFORM == "darwin":
    opencv = EXAMPLES / "OpenCV.ipynb"
    nb = json.loads(opencv.read_text())
    for cell in nb["cells"]:
        if cell["cell_type"] == "code":
            lines = cell["source"]
            for i, line in enumerate(lines):
                if re.findall(r"\s+Open browser", line, flags=re.I):
                    lines[i] = OPENCV_OSX
            print(lines)
            cell["source"] = lines

    opencv.write_text(json.dumps(nb, indent=2))


print("making starters...")
(ETC / "robotlab-starters.json").write_text(json.dumps({
    "StarterManager": {
        "extra_starters": {
            "robotkernel-quickstart": {
                "label": "",
                "description": "",
                "type": "notebook",
                "py_src": "robotkernel",
                "src": "resources/starter/quickstart-starter.ipynb"
            },
            "robotkernel-examples": {
                "type": "copy",
                "label": "More Robot Kernel Examples",
                "description": "Examples of using robotkernel",
                "icon": SVG.read_text().replace("jp-icon2", "jp-icon-contrast1"),
                "src": str(EXAMPLES)
            },
            "robotkernel-tutorial": {
                "label": "Tutorial",
                "description": "Tutorial for Robot Framework on Jupyter",
                "type": "copy",
                "py_src": "robotkernel",
                "src": "resources/notebooks/tutorial",
                "icon": SVG.read_text().replace("jp-icon3", "jp-icon-contrast3")
            }
        }
    }
}, indent=2))
