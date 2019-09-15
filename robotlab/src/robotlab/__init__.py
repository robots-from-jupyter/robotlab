import os

from ._version import __version__  # noqa

from .paths import ROBOTLAB_PATH


def patch_app_dir(app_klass):
    app_klass.app_dir = os.environ["JUPYTERLAB_DIR"] = str(ROBOTLAB_PATH)
    return os.environ["JUPYTERLAB_DIR"]


def patch_build_dir(build_klass):
    build_klass.name = "RobotLab"
