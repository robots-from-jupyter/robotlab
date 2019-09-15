import sys
from jupyterlab import labextensions, labapp

from . import patch_app_dir, patch_build_dir


def main():
    patch_app_dir(labextensions.BaseExtensionApp)
    patch_build_dir(labapp.LabBuildApp)
    return labextensions.main()


if __name__ == "__main__":
    sys.exit(main())
