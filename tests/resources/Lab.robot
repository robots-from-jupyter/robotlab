*** Settings ***
Library           JupyterLibrary

*** Keywords ***
Start a new Notebook
    [Arguments]    ${kernel}
    [Documentation]    Convenience method around
    [Tags]    robot:no-dry-run
    Execute JupyterLab Command    Close All
    Launch a new JupyterLab Document    ${kernel}    Notebook
    Wait Until JupyterLab Kernel Is Idle

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
