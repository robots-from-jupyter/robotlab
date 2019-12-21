*** Settings ***
Documentation     robotlab-tutorial
Force Tags        app:robotlab-tutorial
Resource          ../../../resources/CLI.robot

*** Test Cases ***
Can I install the tutorial?
    [Documentation]    Does robotlab-tutorial work?
    Check a RobotLab CLI command    robotlab-tutorial    check_dir=robotkernel-tutorial
