*** Settings ***
Documentation     robotlab-examples
Force Tags        app:robotlab-examples
Resource          ../../../resources/CLI.robot

*** Test Cases ***
Can I install the examples?
    [Documentation]    Does robotlab-examples work?
    Check a RobotLab CLI command    robotlab-examples    check_dir=robotkernel-examples
