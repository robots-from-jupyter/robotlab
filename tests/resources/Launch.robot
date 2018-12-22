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
    ${port} =   Get Unused Port
    ${base_url} =   Set Variable  /@rlab/
    ${token} =  Generate Random String   64
    @{args} =  Build Jupyter Server Arguments  port=${port}  base_url=${base_url}  token=${token}
    ${proc} =  Start New Jupyter Server   robotlab  ${port}  ${base_url}  ${None}  ${token}  @{args[1:]}  env:PATH=${ROBOTLAB PATH ENV}
