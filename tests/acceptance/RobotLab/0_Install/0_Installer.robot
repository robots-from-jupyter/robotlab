*** Settings ***
Documentation     Is the RobotLab installer viable?
Force Tags        installer
Resource          ../../../resources/Install.robot

*** Test Cases ***
Does the installer run?
    [Documentation]    Will it run?
    Run the installer    RobotLab
