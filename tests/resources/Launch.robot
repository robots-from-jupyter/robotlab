*** Settings ***
Library           OperatingSystem
Library           Process
Library           String

*** Variables ***
${LAB LOG}        ${OUTPUT DIR}${/}01_lab.log
${LAB HOST}       http://127.0.0.1
${LAB PORT}       18888

*** Keywords ***
Launch RobotLab Server
    Should Not Be Empty    ${PLATFORM}    msg=Needs a detected platform/OS
    Should Not Be Empty    ${ROBOTLAB DIR}    msg=Needs a RobotLab installation
    Should Not Be Empty    ${ACTIVATE}    msg=Needs an activate-able environment
    Initialize RobotLab Settings
    Create Directory    ${LAB HOME}
    Run Keyword If    "${platform}" == "win32"    Launch RobotLab Server on Windows
    ...    ELSE    Launch RobotLab Server on Unix

Launch RobotLab Server on Windows
    ${cmd} =    Set Variable    "${ACTIVATE}" "${ROBOTLAB DIR}" && ${LAB COMMAND}
    Log    ${cmd}
    Start Process    @ECHO ON && ${cmd}    stdout=${LAB LOG}    stderr=STDOUT    shell=True

Launch RobotLab Server on Unix
    Start Process    source ${ACTIVATE} ${ROBOTLAB DIR} && ${LAB COMMAND}    stdout=${LAB LOG}    stderr=STDOUT    shell=True

Initialize RobotLab Settings
    ${token} =    Generate Random String    length=64
    Set Global Variable    ${LAB TOKEN}    ${token}
    Set Global Variable    ${LAB URL}    ${LAB HOST}:${LAB PORT}/lab?token=${token}
    Set Global Variable    ${LAB HOME}    ${OUTPUT_DIR}${/}notebooks
    Set Global Variable    ${LAB COMMAND}    robotlab --no-browser --debug --NotebookApp.token=${token} --port=${LAB PORT} --notebook-dir="${LAB HOME}"

Clean the RobotLab notebook folder
    Remove Directory    ${LAB HOME}    recursive=True
    Wait Until Removed    ${LAB HOME}
    Create Directory    ${LAB HOME}
