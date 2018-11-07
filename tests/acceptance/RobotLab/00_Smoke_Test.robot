*** Settings ***
Test Template     Does RobotLab Load?
Library           SeleniumLibrary
Resource          ../../resources/Shell.robot

*** Test Cases ***
Chrome
    headlesschrome

Firefox
    headlessfirefox

*** Keywords ***
Does RobotLab Load?
    [Arguments]    ${browser}
    Open RobotLab    ${browser}
    Page Should Contain    Robot Framework
    Capture Page Screenshot    00_smoke_test.png
