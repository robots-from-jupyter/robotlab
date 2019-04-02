*** Settings ***
Documentation     Work with the RobotLab server
Library           OperatingSystem
Library           JupyterLibrary
Library           String
Library           Process

*** Keywords ***
Start New RobotLab Server
    [Documentation]    Try to start the RobotLab server
    Should Not Be Empty    ${OS}    msg=Needs an OS
    Should Not Be Empty    ${ROBOTLAB DIR}    msg=Needs a RobotLab installation
    Should Not Be Empty    ${ROBOTLAB PATH ENV}    msg=Needs a RobotLab environment
    ${proc} =    Start New Jupyter Server    ${ROBOTLAB CMD}    env:PATH=${ROBOTLAB PATH ENV}

*** Keywords ***
Reset JupyterLab
    Wait Until Keyword Succeeds    2 x    1 s    Execute JupyterLab Command    Reset Application State
