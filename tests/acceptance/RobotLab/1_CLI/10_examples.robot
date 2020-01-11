*** Settings ***
Documentation     robotlab-examples
Force Tags        app:robotlab-examples
Resource          ../../../resources/CLI.robot
Library           Process

*** Test Cases ***
Can I install the examples?
    [Documentation]    Does robotlab-examples work?
    [Tags]    example:opencv
    Check a RobotLab CLI command    robotlab-examples    check_dir=robotkernel-examples

Can I run the examples?
    [Documentation]    Will they nbconvert?
    [Tags]    example:opencv
    ${log} =    Set Variable    ${OUTPUT DIR}${/}robotlab-example-nbconvert-opencv.log
    ${proc} =    Run Process    ${ACTIVATE} && jupyter nbconvert OpenCV.ipynb --execute    shell=True    cwd=${OUTPUT DIR}${/}robotkernel-examples    stdout=${log}    stderr=STDOUT
    ...    env:PS1=[:|]
    Should Be Equal As Numbers    ${proc.rc}    0
