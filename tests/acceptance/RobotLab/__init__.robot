*** Settings ***
Suite Setup       Start New RobotLab Server
Suite Teardown    Terminate All Jupyter Servers
Test Teardown     Wait Until Keyword Succeeds  2 x  1 s  Reset JupyterLab and Close
Force Tags        ui:lab
Library           JupyterLibrary
Resource          ../../resources/Launch.robot
