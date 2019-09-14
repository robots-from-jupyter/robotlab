*** Settings ***
Documentation     nbrobot works with `.ipynb` files as if they were `.robot` files
Force Tags        app:nbrobot
Library           Process
Library           OperatingSystem

*** Test Cases ***
Can I get help on nbrobot?
    [Documentation]    Verify the nbrobot command returns help
    ${log} =    Set Variable    ${OUTPUT DIR}${/}${OS}${/}nbrobot_help.log
    ${proc} =    Run nbrobot    --help    ${log}
    Should Be Equal As Numbers    ${proc.rc}    251
    ${log text} =    Get File    ${log}
    Should Contain    ${log text}    Robot Framework

*** Keywords ***
Run nbrobot
    [Arguments]    ${args}    ${log}
    [Documentation]    Run nbrobot and write the output to a log file
    ${proc} =    Run Process    ${ACTIVATE} && nbrobot ${args}    shell=True    stdout=${log}    stderr=STDOUT    env:PS1=[:|]
    [Return]    ${proc}
