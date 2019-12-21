*** Settings ***
Documentation     nbrobot
Force Tags        app:nbrobot
Resource          ../../../resources/CLI.robot

*** Test Cases ***
Can I get help on nbrobot?
    [Documentation]    Verify the nbrobot command returns help
    ${output} =    Run nbrobot CLI    --help    ${251}
    Should Contain    ${output}    Robot Framework
