*** Settings ***
Library           OperatingSystem
Library           Process
Resource          ./Browser.robot

*** Keywords ***
Clean up the installation
    [Documentation]    Clean out the installed product
    Sleep    5s
    Terminate All Processes
    Sleep    5s
    Terminate All Processes    kill=True
    Sleep    5s
    Run Keyword If    not ${IN_PRODUCT}    Remove Directory    ${PRODUCT DIR}    recursive=True
    Sleep    5s
    Run Keyword If    not ${IN_PRODUCT}    Remove Directory    ${PRODUCT DIR}    recursive=True

Clean Up Examples and Tutorials
    [Documentation]    These are large, and don't prove much if they work
    # Remove Directory    ${OUTPUT DIR}${/}robotkernel-examples    recursive=${True}
    Remove Directory    ${OUTPUT DIR}${/}robotkernel-tutorials    recursive=${True}

Clean Up After Lab Suite
    [Documentation]    Really try to make sure Lab is cleaned up
    Open RobotLab
    Clean Up After Lab Test
    Really Close All Browsers
    Terminate All Jupyter Servers
    Sleep    5s
    Run Keyword and Ignore Error    Terminate All Processes
    Sleep    7s
    Run Keyword and Ignore Error    Terminate All Processes    kill=${True}

Clean Up After Lab Test
    [Documentation]    Try to make sure Lab is cleaned up
    Wait Until Keyword Succeeds    2x    1s    Execute JupyterLab Command    Shutdown All Kernels
    Wait Until Keyword Succeeds    2x    1s    Execute JupyterLab Command    Reset Application State
