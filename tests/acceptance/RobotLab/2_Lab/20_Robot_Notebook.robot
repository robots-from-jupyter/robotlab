*** Settings ***
Documentation     Try out Robot Notebooks
Library           JupyterLibrary
Resource          ../../../resources/Browser.robot
Resource          ../../../resources/Lab.robot

*** Test Cases ***
Can RobotLab make a Robot Notebook?
    [Documentation]    Try a basic Robot Notebook
    ${prefix} =    Set Variable    robot_
    Open RobotLab
    Start a new Notebook    Robot Framework
    Capture Page Screenshot    ${prefix}_01_notebook.png
    Add and Run JupyterLab Code Cell    | *Test Case* |${\n}| Hello |${\n}| | Log | Hello World
    Capture Page Screenshot    ${prefix}_02_execute.png
    Sleep    3s
    Wait Until JupyterLab Kernel Is Idle
    Capture Page Screenshot    ${prefix}_03_execute_result.png
    The Robot Popup Should Contain    ${prefix}    Log    1 passed, 0 failed
    The Robot Popup Should Contain    ${prefix}    Report    All tests passed
    Execute JupyterLab Command    Save Notebook
    Sleep    2s
    Capture Page Screenshot    ${prefix}_09_save.png

*** Keywords ***
The Robot Popup Should Contain
    [Arguments]    ${prefix}    ${document}    ${msg}
    [Documentation]    With an open Robot Notebook, take a look at the log or report
    Click Link    ${document}
    Sleep    1s
    Select Window    Jupyter ${document}
    Page Should Contain    ${msg}
    Capture Page Screenshot    ${prefix}_10_${document.lower()}.png
    Close Window
    Select Window    RobotLab
