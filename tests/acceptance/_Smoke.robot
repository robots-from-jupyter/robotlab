*** Settings ***
Documentation     Verify some properties of the RobotLab installation
Force Tags        smoke
Library           OperatingSystem

*** Test Cases ***
Are there shortcuts?
    [Documentation]    Verify the robotlab shortcuts were created during install
    Variable Should Exist    ${ROBOTLAB SHORTCUT}    msg=Should have defined shortcut during install
    File Should Exist    ${FAKE HOME}${/}Desktop${/}${ROBOTLAB SHORTCUT}    msg=Should have created shortcut during install
