*** Settings ***
Suite Setup       Start New RobotLab Server
Suite Teardown    Terminate All Jupyter Servers
Test Teardown     Test Teardown
Force Tags        ui:lab
Library           JupyterLibrary
Library           SeleniumLibrary
Resource          ../../resources/Launch.robot


*** Keywords ***
Test Teardown
    Wait Until Keyword Succeeds    2 x    1 s    Execute JupyterLab Command    Reset Application State
    Close Browser
