*** Settings ***
Suite Setup       Start New RobotLab Server
Suite Teardown    Terminate All Jupyter Servers
Test Teardown     Run Keywords    Wait Until Keyword Succeeds    2 x    1 s    Execute JupyterLab Command    Reset Application State
...               AND    Run keyword And Ignore Error    Handle Alert    timeout=1 s
...               AND    Close Browser
Force Tags        ui:lab
Library           JupyterLibrary
Resource          ../../resources/Launch.robot
