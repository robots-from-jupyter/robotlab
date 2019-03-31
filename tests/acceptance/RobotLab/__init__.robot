*** Settings ***
Suite Setup       Start New RobotLab Server
Suite Teardown    Terminate All Jupyter Servers
Test Teardown     Run keywords
...               Reset JupyterLab and Close
...               Close all browsers
Force Tags        ui:lab
Library           SeleniumLibrary
Library           JupyterLibrary
Resource          ../../resources/Launch.robot
