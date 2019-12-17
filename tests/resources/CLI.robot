*** Settings ***
Documentation     Keywords for CLIs we ship
Library           Process
Library           OperatingSystem

*** Keywords ***
Check a RobotLab CLI Command
    [Arguments]    ${cmd}    ${check_dir}=${EMPTY}
    [Documentation]    Verify the CLI command works
    ${prefix} =    Set Variable    ${OUTPUT DIR}
    ${log} =   Set Variable   ${prefix}${/}cli-${cmd.split()[0]}.log
    ${proc} =    Run Process    ${ACTIVATE} && ${cmd}    shell=True    cwd=${prefix}    stdout=${log}    stderr=STDOUT
    Should Be Equal As Numbers    ${proc.rc}    0
    Run Keyword If    "${check_dir}"    Directory Should Not Be Empty    ${prefix}${/}${check_dir}
    ${output} =  Get File  ${log}
    [Return]  ${output}

Run nbrobot CLI
    [Arguments]    ${args}    ${log}    ${rc}=${0}
    [Documentation]    Run nbrobot and write the output to a log file
    ${proc} =    Run Process    ${ACTIVATE} && nbrobot ${args}    shell=True    stdout=${log}    stderr=STDOUT    env:PS1=[:|]
    Run Keyword If    ${rc} is not None    Should Be Equal As Numbers    ${proc.rc}    ${rc}
    [Return]    ${proc}
