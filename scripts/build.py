import sys

from jinja2 import Template

from . import (
    CONDA_CACHE,
    CONDA_OUT,
    CONSTRUCT_CACHE,
    CONSTRUCT_DIR,
    CONSTRUCT_OUT,
    CONSTRUCT,
    FIREFOX_VERSION,
    IPYWIDGETS_VERSION,
    NODE_MAX,
    NODE_MIN,
    PLATFORM,
    PY_MAX,
    PY_MIN,
    RECIPE_DIR,
    RF_VERSION,
    RK_VERSION,
    SCRIPT_EXT,
    VERSION,
    run,
)


CONSTRUCT_IN = Template((CONSTRUCT_DIR / "construct.yaml.in").read_text())


def build_conda(packages=None, force=False):
    """ Build some packages (mostly re-arching conda-forge `noarch: python`)
    """

    [
        p.unlink()
        for p in (
            list(CONDA_OUT.rglob("*.json"))
            + list(CONDA_OUT.rglob("*.json.bz2"))
        )
    ]

    if packages:
        force = True
    else:
        packages = ["."]

    for package in packages:

        rc = run(
            [
                "conda-build",
                package,
                "--output-folder",
                CONDA_OUT,
                "--cache-dir",
                CONDA_CACHE,
                "-c",
                "https://conda.anaconda.org/conda-forge",
                "-c",
                "https://conda.anaconda.org/anaconda",
                "-c",
                "https://conda.anaconda.org/pythonnet",
                "--python",
                PY_MIN,
            ]
            + ([] if force else ["--skip-existing"]),
            cwd=str(RECIPE_DIR),
        )
        if rc:
            return rc

    return 0


def build_constructor():
    """ Use the local build artifacts in constructor

        Care should be taken to avoid `noarch: python` packages
    """
    construct = CONSTRUCT_IN.render(
        build_channel=CONDA_OUT.as_uri(),
        ff_version=FIREFOX_VERSION,
        ipyw_version=IPYWIDGETS_VERSION,
        node_max=NODE_MAX,
        node_min=NODE_MIN,
        platform=PLATFORM,
        py_max=PY_MAX,
        py_min=PY_MIN,
        rf_version=RF_VERSION,
        rk_version=RK_VERSION,
        script_ext=SCRIPT_EXT,
        version=VERSION,
    )

    CONSTRUCT.write_text(construct)

    CONSTRUCT_OUT.mkdir(exist_ok=True)

    return run(
        [
            "constructor",
            ".",
            "--output-dir",
            str(CONSTRUCT_OUT),
            "--cache-dir",
            str(CONSTRUCT_CACHE),
            "--verbose",
        ],
        cwd=str(CONSTRUCT_DIR),
    )


if __name__ == "__main__":
    if len(sys.argv) > 1:
        if sys.argv[1] == "conda":
            sys.exit(build_conda(sys.argv[2:]))
        elif sys.argv[1] == "constructor":
            sys.exit(build_constructor())

    if build_conda() == 0:
        sys.exit(build_constructor())
    sys.exit(1)
