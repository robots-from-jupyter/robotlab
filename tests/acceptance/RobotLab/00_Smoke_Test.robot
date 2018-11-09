*** Settings ***
Documentation     Check the basics of Robot Lab
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
    [Documentation]    Does the Lab launcher show up with a Robot Framework entry?
    Set Tags    browser:${browser}
    Open RobotLab    ${browser}
    Page Should Contain    Robot Framework
    Capture Page Screenshot    00_smoke_test.png
