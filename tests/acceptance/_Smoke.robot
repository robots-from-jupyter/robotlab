*** Settings ***
Documentation     Verify some properties of the RobotLab installation
Force Tags        smoke
Library           OperatingSystem

*** Test Cases ***
Are there shortcuts?
    [Documentation]    Verify the robotlab shortcuts were created during install
    Directory Should Not Be Empty    ${FAKE HOME}${/}Desktop${/}RobotLab
    Shortcut Should Exist  Lab
    Shortcut Should Exist  Shell


*** Keywords ***
Shortcut should Exist
    [Arguments]   ${name}
