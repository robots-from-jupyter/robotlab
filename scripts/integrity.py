import re

from . import ROOT, RECIPE_DIR, ROBOTLAB_DIR, SCRIPTS_DIR, TEST_DIR


META_PATTERN = r""" set version = "([\d\.rc]+)" """

VERSIONS = {
    ROOT / "azure-pipelines.yml": r"ROBOTLAB_VERSION: ([\d\.rc]+)",
    RECIPE_DIR / "robotlab" / "meta.yaml": META_PATTERN,
    ROBOTLAB_DIR / "setup.cfg": r"version = ([\d\.rc]+)",
    ROBOTLAB_DIR
    / "src"
    / "robotlab"
    / "_version.py": r"""__version__ = "([\d\.rc]+)""",
    SCRIPTS_DIR / "__init__.py": r"""ROBOTLAB_VERSION", "([\d\.rc]+)""",
    TEST_DIR
    / "resources"
    / "Install.robot": r"\$\{INSTALLER VERSION\}\s+([\d\.rc]+)",
}


def ensure_integrity():
    versions = {}
    for path, pattern in VERSIONS.items():
        print(path.relative_to(ROOT))
        versions[path] = re.findall(pattern, path.read_text())[0]
        print("\t", versions[path])

    assert len(set(versions.values())) == 1, versions


if __name__ == "__main__":
    ensure_integrity()
