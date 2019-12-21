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
