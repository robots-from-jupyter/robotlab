#!/usr/bin/env python3
from pathlib import Path
import sys
from jinja2 import Template
import subprocess

from ruamel_yaml import safe_load

OK = 0
ERROR = 1

HERE = Path(__file__).parent
ROOT = (HERE / "..").resolve()
ARTIFACTS = ROOT / "build_artifacts"
BLD = ARTIFACTS / "conda-bld"
OUT = ARTIFACTS / "constructor"
CACHE = ROOT / "cache" / "constructor"

CONSTRUCT = HERE / "construct.yaml"

PROJECT = safe_load((ROOT / "anaconda-project.yml").read_text())
CONSTRUCT_IN = Template((HERE / "construct.yaml.in").read_text())

ARGS = [
    "constructor", ".",
    "--output-dir", str(OUT),
    "--cache-dir", str(CACHE),
    "--verbose",
]


def build():
    """ Use the packages defined in the project file to build a constructor

        Care should be taken to avoid `noarch: python` packages
    """
    packages = PROJECT["env_specs"]["default"]["packages"]
    construct = CONSTRUCT_IN.render(
        build_channel=BLD.as_uri(),
        specs=packages,
    )

    CONSTRUCT.write_text(construct)

    OUT.mkdir(exist_ok=True)

    p = subprocess.Popen(ARGS)

    try:
        p.wait()
    except KeyboardInterrupt:
        p.kill()

    return OK


if __name__ == "__main__":
    sys.exit(build())
