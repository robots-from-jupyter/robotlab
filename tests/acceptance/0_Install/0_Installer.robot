*** Settings ***
Documentation     Is the RobotLab installer viable?
Resource          ../../resources/Install.robot

*** Test Cases ***
Does the installer run?
    [Documentation]    Will it run?
    Run the RobotLab installer
