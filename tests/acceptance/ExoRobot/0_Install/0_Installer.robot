*** Settings ***
Documentation     Is the ExoRobot installer viable?
Resource          ../../../resources/Install.robot

*** Test Cases ***
Does the installer run?
    [Documentation]    Will it run?
    Run the installer    ExoRobot
