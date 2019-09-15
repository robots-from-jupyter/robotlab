*** Settings ***
Documentation     Keywords for CLIs we ship
Library           Process
Library           OperatingSystem

*** Keywords ***
Check a RobotLab CLI command
    [Arguments]    ${cmd}    ${check_dir}=${True}
    [Documentation]    Verify the robotlab CLI command works
    ${prefix} =    Set Variable    ${OUTPUT DIR}${/}${OS}
    ${proc} =    Run Process    ${ACTIVATE} && ${cmd}    shell=True    cwd=${prefix}    stdout=${prefix}${/}cli-${cmd}.log    stderr=STDOUT
    Should Be Equal As Numbers    ${proc.rc}    0
    Run Keyword If    ${check_dir}    Directory Should Not Be Empty    ${prefix}${/}${cmd}

Run nbrobot CLI
    [Arguments]    ${args}    ${log}    ${rc}=${0}
    [Documentation]    Run nbrobot and write the output to a log file
    ${proc} =    Run Process    ${ACTIVATE} && nbrobot ${args}    shell=True    stdout=${log}    stderr=STDOUT    env:PS1=[:|]
    Run Keyword If    ${rc} is not None    Should Be Equal As Numbers    ${proc.rc}    ${rc}
    [Return]    ${proc}
