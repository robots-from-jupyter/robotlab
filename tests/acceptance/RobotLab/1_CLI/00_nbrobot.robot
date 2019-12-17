*** Settings ***
Documentation     nbrobot
Force Tags        app:nbrobot
Resource          ../../../resources/CLI.robot

*** Test Cases ***
Can I get help on nbrobot?
    [Documentation]    Verify the nbrobot command returns help
    ${log} =    Set Variable    ${OUTPUT DIR}${/}cli-nbrobot-help.log
    ${proc} =    Run nbrobot CLI    --help    ${log}    ${251}
    ${log text} =    Get File    ${log}
    Should Contain    ${log text}    Robot Framework
