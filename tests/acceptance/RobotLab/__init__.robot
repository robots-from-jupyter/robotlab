*** Settings ***
Suite Setup       Launch RobotLab Server
Suite Teardown    Terminate All Processes
Test Teardown     Reset Application State and Close
Force Tags        ui:lab
Library           SeleniumLibrary
Library           Process
Resource          ../../resources/Launch.robot
