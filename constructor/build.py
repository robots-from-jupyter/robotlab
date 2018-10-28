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
BLD = ROOT / "build_artifacts" / "conda-bld"

CONSTRUCT = HERE / "construct.yaml"


PROJECT = safe_load((ROOT / "anaconda-project.yml").read_text())
PROJECT_LOCK = safe_load((ROOT / "anaconda-project-lock.yml").read_text())
CONSTRUCT_IN = Template((HERE / "construct.yaml.in").read_text())


def build():
    construct = CONSTRUCT_IN.render(
        build_channel=BLD.as_uri(),
        specs=PROJECT_LOCK["env_specs"]["default"]["packages"],
    )

    CONSTRUCT.write_text(construct)

    p = subprocess.Popen(["constructor", "."])

    try:
        p.wait()
    except KeyboardInterrupt:
        p.kill()
        return ERROR

    return OK


if __name__ == "__main__":
    sys.exit(build())
