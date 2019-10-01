*** Settings ***
Documentation     Do Desktop shortcuts get installed?
Resource          ../../../resources/Install.robot

*** Test Cases ***
Are the shortcuts created?
    [Documentation]    Does it cut short?
    Variable Should Exist    ${ROBOTLAB SHORTCUT}    msg=Should have defined shortcut during install
    # TODO: dump the create shortcuts in the env and check them
    # ${home} =    Set Variable If    ${IN_PRODUCT}    %{HOME}    ${FAKE HOME}
    # Wait Until Created    ${home}${/}Desktop${/}${ROBOTLAB SHORTCUT}
