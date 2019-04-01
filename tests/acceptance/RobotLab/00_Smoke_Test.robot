*** Settings ***
Documentation     Check the basics of Robot Lab
Test Template     Does RobotLab Load?
Library           JupyterLibrary

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
    Wait until keyword succeeds    3 x    1 s
    ...  Open JupyterLab    browser=${browser}
    Page Should Contain    Robot Framework
    Capture Page Screenshot    ${browser}_smoke__00_smoke_test.png
