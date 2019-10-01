import sys

from jinja2 import Template

from . import (
    CONDA_BUILD_ARGS,
    CONDA_OUT,
    CONDA_VERSION,
    CONSTRUCT_DIR,
    CONSTRUCT_OUT,
    CONSTRUCTOR_ARGS,
    LAB_OUT,
    LABEXTENSIONS,
    PY_MAX,
    PY_MIN,
    RECIPE_DIR,
    RF_VERSION,
    run,
    VERSION,
)


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
        args = [*CONDA_BUILD_ARGS, *extra_args, package]
        rc = rc or run(args, cwd=str(RECIPE_DIR))

    return rc


def build_constructor(construct):
    """ Use the local build artifacts in constructor
    """
    construct_dir = CONSTRUCT_DIR / construct

    construct_yaml_in = Template(
        (construct_dir / "construct.yaml.in").read_text()
    )

    construct_yaml = construct_yaml_in.render(
        build_channel=CONDA_OUT.as_uri(),
        py_max=PY_MAX,
        py_min=PY_MIN,
        version=VERSION,
        rf_version=RF_VERSION,
        conda_version=CONDA_VERSION,
    )

    (construct_dir / "construct.yaml").write_text(construct_yaml)

    print(construct_yaml)

    CONSTRUCT_OUT.mkdir(exist_ok=True, parents=True)

    return run(CONSTRUCTOR_ARGS, cwd=str(construct_dir))


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

    all_constructs = sorted(CONSTRUCT_DIR.glob("*/"))

    if len(sys.argv) > 1:
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
            rc = 0
            constructs = rest or all_constructs
            print(f"building {constructs}")
            for construct in constructs:
                rc = rc or build_constructor(construct)
    else:
        rc = build_conda()
        print(f"building {all_constructs}")
        for construct in all_constructs:
            rc = rc or build_constructor(construct)

    sys.exit(rc)
