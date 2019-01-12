*** Settings ***
Documentation     robotlab ships the robokernel tutorial
Force Tags        app:robotlab-tutrial
Library           Process
Library           OperatingSystem

*** Test Cases ***
Can I install the tutorial?
    [Documentation]    Verify the robotlab-tutorial command works
    Run Process    ${ACTIVATE} && robotlab-tutorial    shell=True    cwd=${OUTPUT DIR}${/}${OS}
    Directory Should Not Be Empty    ${OUTPUT DIR}${/}${OS}${/}robotkernel-tutorial
