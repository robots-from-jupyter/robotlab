import sys
from jupyterlab import labapp

from . import patch_app_dir


def main():
    patch_app_dir(labapp.LabApp)
    labapp.main()


if __name__ == "__main__":
    sys.exit(main())
