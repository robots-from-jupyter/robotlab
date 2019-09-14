*** Settings ***
Documentation     Check the basics of Robot Lab
Library           JupyterLibrary
Resource          ../../resources/Browser.robot

*** Test Cases ***
Does RobotLab Load?
    [Documentation]    Does the Lab launcher show up with a Robot Framework entry?
    Wait until keyword succeeds    3 x    1 s    Open RobotLab
    Page Should Contain    Robot Framework
    Capture Page Screenshot    smoke__00_smoke_test.png
