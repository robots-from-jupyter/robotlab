*** Settings ***
Documentation     Try out IPython Notebooks
Library           JupyterLibrary
Resource          ../../../resources/Browser.robot
Resource          ../../../resources/Lab.robot

*** Test Cases ***
Can RobotLab make an IPython Notebook?
    [Documentation]    Try a basic IPython Notebook
    ${prefix} =    Set Variable    ipython_
    Open RobotLab
    Start a new Notebook    Python 3
    Capture Page Screenshot    ${prefix}_01_notebook.png
    Add and Run JupyterLab Code Cell    print("Hello" + " World")
    Capture Page Screenshot    ${prefix}_02_execute.png
    Wait Until Page Contains    Hello World    timeout=10s
    Capture Page Screenshot    ${prefix}_03_execute_result.png
    Execute JupyterLab Command    Save Notebook
    Sleep    2s
    Capture Page Screenshot    ${prefix}_09_save.png
