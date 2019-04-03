@echo on
set RFWL_URL=https://files.pythonhosted.org/packages/ab/41/9697824c3d4daa6d4545081ac7aec83fa410f13b92670c05d4099796998e/robotframework_whitelibrary-%PKG_VERSION%-py2.py3-none-any.whl
set RFWL_SHA256=9976ed2e7f58a4fa1510eab640560b0eb0f2c67f7b075bce30385c110c524a12

rem --hash sha256:%RFWL_SHA256%
call python -m pip install --disable-pip-version-check --no-deps %RFWL_URL% -vvv
if errorlevel 1 exit 1
