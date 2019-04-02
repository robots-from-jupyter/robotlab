*** Settings ***
Suite Setup       Start New RobotLab Server
Suite Teardown    Terminate All Jupyter Servers
Test Teardown     Run Keywords   Reset JupyterLab  Close Browser
Force Tags        ui:lab
Library           JupyterLibrary
Library           SeleniumLibrary
Resource          ../../resources/Launch.robot
