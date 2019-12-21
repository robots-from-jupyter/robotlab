*** Settings ***
Documentation     CLI features
Suite Teardown    Clean Up After CLI
Force Tags        ui:cli
Library           Process
Resource          ../../../resources/Cleanup.robot

*** Keywords ***
Clean Up After CLI
    [Documentation]    Ensure any dangling processes or files are cleaned
    Run Keyword If All Tests Passed    Clean Up Examples and Tutorials
    Terminate All Processes
