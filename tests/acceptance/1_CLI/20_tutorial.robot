*** Settings ***
Documentation     robotlab ships the robokernel tutorial
Force Tags        app:robotlab-tutorial
Resource          ../../resources/CLI.robot

*** Test Cases ***
Can I install the tutorial?
    [Documentation]    Verify the robotlab-tutorial command works
    Check A RobotLab CLI Command    robotlab-examples
