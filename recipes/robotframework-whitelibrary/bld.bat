@echo on
set RFWL_URL=https://files.pythonhosted.org/packages/ff/e9/0e460d1d6609a6cda95dbd76192f0c828089e91fd52eac93dc22df7eda08/robotframework_whitelibrary-%PKG_VERSION%-py2.py3-none-any.whl
set RFWL_SHA256=8e44bcf3db2a60858230129596e93b30b692f3657977b62c7174dacb890a7339

call python -m pip install --disable-pip-version-check --no-deps %RFWL_URL% -vv
if errorlevel 1 exit 1
