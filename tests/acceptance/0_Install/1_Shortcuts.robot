*** Settings ***
Documentation     Do Desktop shortcuts get installed?
Resource          ../../resources/Install.robot

*** Test Cases ***
Are the shortcuts created?
    [Documentation]    Does it cut short?
    Variable Should Exist    ${ROBOTLAB SHORTCUT}    msg=Should have defined shortcut during install
    ${home} =    Set Variable If    ${IN_ROBOTLAB}    %{HOME}    ${FAKE HOME}
    Wait Until Created    ${home}${/}Desktop${/}${ROBOTLAB SHORTCUT}
