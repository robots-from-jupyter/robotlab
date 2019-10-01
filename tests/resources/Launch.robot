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
    Should Not Be Empty    ${PRODUCT DIR}    msg=Needs a RobotLab installation
    Should Not Be Empty    ${PRODUCT PATH ENV}    msg=Needs a RobotLab environment
    ${proc} =    Start New Jupyter Server    ${ROBOTLAB CMD}    env:PATH=${PRODUCT PATH ENV}
