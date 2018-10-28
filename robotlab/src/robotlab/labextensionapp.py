import sys
from jupyterlab import labextensions

from . import patch_app_dir


def main():
    patch_app_dir(labextensions.BaseExtensionApp)
    labextensions.main()


if __name__ == "__main__":
    sys.exit(main())
