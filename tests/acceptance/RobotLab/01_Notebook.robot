*** Settings ***
Documentation     Try out some browsers with RobotLab Notebooks
Test Template     Can I make a Robot Notebook?
Library           SeleniumLibrary
Resource          ../../resources/Launch.robot
Resource          ../../resources/Shell.robot
Resource          ../../resources/Notebook.robot

*** Test Cases ***
Chrome
    headlesschrome

Firefox
    headlessfirefox

*** Keywords ***
Can I make a Robot Notebook?
    [Arguments]    ${browser}
    [Documentation]    Try the basic Robot Notebook REPL
    Set Tags    browser:${browser}
    Open RobotLab    ${browser}
    Launch a new    Robot Framework    Notebook
    Capture Page Screenshot    01_notebook.png
    Add and Run Cell    | *Test Case* |${\n}| Hello |${\n}| | Log | Hello World
    Capture Page Screenshot    02_execute.png
    Wait Until Kernel Is Idle
    Capture Page Screenshot    03_execute_result.png
    The Robot Popup Should Contain    Log    1 passed, 0 failed
    The Robot Popup Should Contain    Report    All tests passed
    Execute JupyterLab Command    Save Notebook
    Capture Page Screenshot    09_save.png

The Robot Popup Should Contain
    [Arguments]    ${document}    ${msg}
    [Documentation]    With an open Robot Notebook, take a look at the log or report
    Click Link    ${document}
    Sleep    1s
    Select Window    Jupyter ${document}
    Page Should Contain    ${msg}
    Capture Page Screenshot    10_${document.lower()}.png
    Close Window
    Select Window    JupyterLab
