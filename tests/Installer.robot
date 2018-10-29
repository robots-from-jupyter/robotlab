*** Settings ***
Library  SeleniumLibrary
Library  OperatingSystem

*** Test Cases ***
Smoke Test
  [Teardown]  Clean up after Installer
  Run the Installer
  Start RobotLab
  Run the Example Notebooks

*** Keywords ***
Run the Installer
  Log   TBD

Start RobotLab
  Log   TBD

Run the Example Notebooks
  Log   TBD

Clean up after Installer
  Log   TBD
