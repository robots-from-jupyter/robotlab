import os

from ._version import __version__  # noqa

from .paths import ROBOTLAB_PATH


def patch_app_dir(app_klass):
    path = str(ROBOTLAB_PATH)
    os.environ["JUPYTERLAB_DIR"] = path
    app_klass.app_dir.default_value = path
    return path


def patch_build_dir(build_klass):
    build_klass.name.default_value = "RobotLab"
