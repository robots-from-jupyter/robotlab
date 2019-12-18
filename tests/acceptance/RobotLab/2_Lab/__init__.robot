*** Settings ***
Suite Setup       Start New RobotLab Server
Suite Teardown    Clean Up After Lab Suite
Test Teardown     Clean Up After Lab Test
Force Tags        ui:lab
Library           JupyterLibrary
Library           Process
Resource          ../../../resources/Launch.robot
Resource          ../../../resources/Cleanup.robot
