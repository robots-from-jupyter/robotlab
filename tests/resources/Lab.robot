*** Settings ***
Library    JupyterLibrary

*** Keywords ***
Start a new Notebook
    [Arguments]    ${kernel}
    [Tags]   robot:no-dry-run
    [Documentation]  Convenience method around
    Execute JupyterLab Command    Close All
    Launch a new JupyterLab Document    ${kernel}    Notebook
    Wait Until JupyterLab Kernel Is Idle
