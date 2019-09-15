*** Settings ***
Suite Setup       Start New RobotLab Server
Suite Teardown    Run Keywords    Terminate All Jupyter Servers    Close All Browsers    Terminate All Processes
Test Teardown     Run Keywords    Wait Until Keyword Succeeds    2 x    1 s    Execute JupyterLab Command    Reset Application State
...               AND    Run keyword And Ignore Error    Handle Alert    timeout=1 s
...               AND    Close Browser
Force Tags        ui:lab
Library           JupyterLibrary
Library           Process
Resource          ../../resources/Launch.robot
