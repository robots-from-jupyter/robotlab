@ECHO ON
cd src\utest

CALL python run.py || EXIT /B 1
IF %ERRORLEVEL% NEQ 0 EXIT /B %ERRORLEVEL%
