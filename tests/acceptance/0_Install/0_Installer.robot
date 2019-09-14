*** Settings ***
Documentation     Is the RobotLab installer viable?
Resource          ../../resources/Install.robot

*** Test Cases ***
Does the installer run?
    [Documentation]    Will it run?
    Run the RobotLab installer
    Variable Should Exist    ${ROBOTLAB SHORTCUT}    msg=Should have defined shortcut during install
    File Should Exist    ${FAKE HOME}${/}Desktop${/}${ROBOTLAB SHORTCUT}    msg=Should have created shortcut during install
