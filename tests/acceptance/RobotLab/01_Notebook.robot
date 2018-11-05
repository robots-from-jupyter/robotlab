*** Settings ***
Library  SeleniumLibrary
Resource  ../../resources/Shell.robot
Resource  ../../resources/Notebook.robot
Test Template   Can I make a Robot Notebook?

*** Test Cases ***
Chrome   headlesschrome
Firefox  headlessfirefox

*** Keywords ***
Can I make a Robot Notebook?
  [arguments]  ${browser}
  Open RobotLab  ${browser}
  Launch a new  Robot Framework  Notebook
  Capture Page Screenshot  01_notebook.png
  Add and Run Cell  | Test Case |${\n}| Hello |${\n}| | Log | Hello World
  Capture Page Screenshot  02_execute.png
  Wait Until Kernel Is Idle
  Capture Page Screenshot  03_execute_result.png
  Execute JupyterLab Command    Save Notebook
  Capture Page Screenshot  04_save.png
