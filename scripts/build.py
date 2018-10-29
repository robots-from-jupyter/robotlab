import sys

from . import (
    CONDA_OUT, RECIPE_DIR, CONSTRUCT_IN, CONSTRUCT, CONSTRUCT_OUT,
    CONSTRUCT_CACHE, CONSTRUCT_DIR, PY_MIN, PY_MAX, NODE_MIN, NODE_MAX,
    run
)


def build_conda():
    """ Build some packages (mostly re-arching conda-forge `noarch: python`)
    """
    return run([
        "conda-build", ".",
        "--output-folder", CONDA_OUT,
        "--python", PY_MIN
    ], cwd=str(RECIPE_DIR))


def build_constructor():
    """ Use the local build artifacts in constructor

        Care should be taken to avoid `noarch: python` packages
    """
    construct = CONSTRUCT_IN.render(
        build_channel=CONDA_OUT.as_uri(),
        py_min=PY_MIN,
        py_max=PY_MAX,
        node_min=NODE_MIN,
        node_max=NODE_MAX
    )

    CONSTRUCT.write_text(construct)

    CONSTRUCT_OUT.mkdir(exist_ok=True)

    return run([
        "constructor", ".",
        "--output-dir", str(CONSTRUCT_OUT),
        "--cache-dir", str(CONSTRUCT_CACHE),
        "--verbose"
    ], cwd=str(CONSTRUCT_DIR))


if __name__ == "__main__":
    if build_conda() == 0:
        if build_constructor() == 0:
            sys.exit(0)
    sys.exit(1)
