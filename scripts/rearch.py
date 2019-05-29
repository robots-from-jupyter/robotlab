from pathlib import Path
import sys
import shutil
from tempfile import TemporaryDirectory

from . import RECIPE_DIR, run

CF = "https://github.com/conda-forge/{}-feedstock.git"


def rearch(pkgs):
    for pkg in pkgs:
        with TemporaryDirectory() as td:
            run(["git", "clone", "--depth=1", CF.format(pkg), pkg], cwd=td)

            recipe_in = Path(td) / pkg / "recipe"
            recipe_out = RECIPE_DIR / pkg
            meta = recipe_in / "meta.yaml"

            meta.write_text(
                "\n".join(
                    [
                        line
                        for line in meta.read_text().split("\n")
                        if "noarch: python" not in line
                    ]
                )
            )

            shutil.copytree(recipe_in, recipe_out)


if __name__ == "__main__":
    sys.exit(rearch(sys.argv[1:]))
