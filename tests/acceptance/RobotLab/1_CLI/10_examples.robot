*** Settings ***
Documentation     robotlab ships the robokernel examples
Force Tags        app:robotlab-examples
Resource          ../../../resources/CLI.robot

*** Test Cases ***
Can I install the examples?
    [Documentation]    Verify the robotlab-examples command works
    Check a RobotLab CLI command    robotlab-examples
