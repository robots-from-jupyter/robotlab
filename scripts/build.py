import sys

from jinja2 import Template

from . import (
    CONDA_BUILD_ARGS,
    CONDA_OUT,
    CONSTRUCTOR_ARGS,
    CONSTRUCT_DIR,
    CONSTRUCT_OUT,
    CONSTRUCT,
    LABEXTENSIONS,
    LAB_OUT,
    PLATFORM,
    PY_MAX,
    PY_MIN,
    RECIPE_DIR,
    SCRIPT_EXT,
    VERSION,
    run,
)


CONSTRUCT_IN = Template((CONSTRUCT_DIR / "construct.yaml.in").read_text())


def build_conda(packages=None, force=False, no_test=False):
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

    extra_args = []
    extra_args += [] if force else ["--skip-existing"]
    extra_args += ["--no-test"] if no_test else []

    rc = 0

    for package in packages:
        rc = rc or run(
            [*CONDA_BUILD_ARGS, extra_args, package], cwd=str(RECIPE_DIR)
        )

    return rc


def build_constructor():
    """ Use the local build artifacts in constructor

        Care should be taken to avoid `noarch: python` packages
    """
    construct = CONSTRUCT_IN.render(
        build_channel=CONDA_OUT.as_uri(),
        platform=PLATFORM,
        py_max=PY_MAX,
        py_min=PY_MIN,
        script_ext=SCRIPT_EXT,
        version=VERSION,
    )

    CONSTRUCT.write_text(construct)

    CONSTRUCT_OUT.mkdir(exist_ok=True)

    return run(CONSTRUCTOR_ARGS, cwd=str(CONSTRUCT_DIR))


def build_lab():
    JP = [sys.executable, "-m", "jupyter"]
    app_dir = ["--app-dir", LAB_OUT]

    rc = run(
        [
            *JP,
            "labextension",
            "install",
            "--no-build",
            *app_dir,
            *LABEXTENSIONS,
        ]
    )
    rc = rc or run(
        [
            *JP,
            "lab",
            "build",
            *app_dir,
            "--dev-build=False",
            "--minimize=True",
            "--name='RobotLab'",
        ]
    )

    return rc


if __name__ == "__main__":
    rc = 1

    if len(sys.argv) > 1:
        args = sys.argv[1]

        it, rest = sys.argv[1], sys.argv[2:]
        if it == "lab":
            rc = build_lab()
        elif it == "conda":
            no_test = False
            if "--no-test" in rest:
                no_test = True
                rest.remove("--no-test")
            rc = build_conda(rest, no_test=no_test)
        elif it == "constructor":
            rc = build_constructor()
    else:
        rc = build_conda()
        rc = rc or build_constructor()

    sys.exit(rc)
