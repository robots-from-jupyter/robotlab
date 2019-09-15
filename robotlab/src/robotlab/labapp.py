import sys
from jupyterlab import labapp

from . import patch_app_dir, patch_build_dir


def main():
    patch_app_dir(labapp.LabApp)
    patch_build_dir(labapp.LabBuildApp)
    return labapp.main()


if __name__ == "__main__":
    sys.exit(main())
