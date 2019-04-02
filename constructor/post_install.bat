@echo on
"%PREFIX%\Scripts\activate.bat" "%PREFIX%"
python -m pip install ^
  --no-index ^
  --find-links %PREFIX%/share/wheelhouse ^
  robotframework-whitelibrary ^
  pythonnet

robotlab-shortcuts
