*** Settings ***
Documentation     Keywords for CLIs we ship
Library           Process
Library           OperatingSystem

*** Variables ***
${NEXT CLI LOG}    ${0}

*** Keywords ***
Check a RobotLab CLI Command
    [Arguments]    ${cmd}    ${check_dir}=${EMPTY}    ${rc}=${0}
    [Documentation]    Run a command in the robotlab environment
    ${logs} =    Set Variable    ${OUTPUT DIR}${/}cli
    Create Directory    ${logs}
    ${log} =    Set Variable    ${logs}${/}${NEXT CLI LOG}-${cmd.split()[0]}.log
    Set Global Variable    ${NEXT CLI LOG}    ${NEXT CLI LOG.__add__(1)}
    ${proc} =    Run Process    ${ACTIVATE} && ${cmd}    shell=True    cwd=${OUTPUT DIR}    stdout=${log}    stderr=STDOUT
    ...    env:PS1=[:|]
    Should Be Equal As Numbers    ${proc.rc}    ${rc}
    Run Keyword If    "${check_dir}"    Directory Should Not Be Empty    ${OUTPUT DIR}${/}${check_dir}
    ${output} =    Get File    ${log}
    [Return]    ${output}

Run nbrobot CLI
    [Arguments]    ${args}    ${rc}=${0}
    [Documentation]    Run nbrobot and write the output to a log file
    ${output} =    Check a RobotLab CLI Command    nbrobot ${args}    rc=${rc}
    [Return]    ${output}
