*** Settings ***
Suite Setup       Start New RobotLab Server
Suite Teardown    Terminate All Jupyter Servers
Test Teardown     Reset JupyterLab and Close
Force Tags        ui:lab
Library           SeleniumLibrary
Library           JupyterLibrary
Resource          ../../resources/Launch.robot
