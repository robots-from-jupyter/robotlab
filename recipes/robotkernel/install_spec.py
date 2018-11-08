import json
import os
import shutil
import sys
from pathlib import Path

NAME = "robotkernel"
KERNEL_SPECS = Path(sys.prefix) / "share" / "jupyter" / "kernels"
ROBOTKERNEL = KERNEL_SPECS / NAME
KERNEL_JSON = ROBOTKERNEL / "kernel.json"

SRC_RESOURCES = Path(os.environ["SRC_DIR"]) / "src" / NAME / "resources"


def main():
    print(f"Copying {NAME} resources to {ROBOTKERNEL}...")
    KERNEL_SPECS.mkdir(parents=True, exist_ok=True)
    shutil.copytree(SRC_RESOURCES, ROBOTKERNEL)
    print(f"Writing {KERNEL_JSON}...")
    KERNEL_JSON.write_text(json.dumps({
        'argv': [
            sys.executable,
            '-m',
            'robotkernel.kernel',
            '-f',
            '{connection_file}',
        ],
        'codemirror_mode': 'robotframework',
        'display_name': 'Robot Framework',
        'language': 'robotframework',
    }, indent=2))


if __name__ == '__main__':
    main()
