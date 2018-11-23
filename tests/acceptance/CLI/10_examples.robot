*** Settings ***
Documentation     robotlab ships the robokernel examples
Force Tags        app:robotlab-examples
Library           Process
Library           OperatingSystem

*** Test Cases ***
Can I install the examples?
    [Documentation]    Verify the robotlab-examples command works
    Run Process    robotlab-examples    cwd=${OUTPUT DIR}
    Directory Should Not Be Empty    ${OUTPUT DIR}${/}robotkernel-examples
