*** Settings ***
Library  SeleniumLibrary
Library  Process
Resource  ../../resources/Launch.robot
Suite Setup  Launch RobotLab Server
Test Teardown  Reset Application State and Close
Suite Teardown  Terminate All Processes
