*** Settings ***
Library  SeleniumLibrary
Library  Process
Resource  ../../resources/Launch.robot
Resource  ../../resources/Shell.robot
Suite Setup  Launch RobotLab Server
Test Teardown  Close All Browsers
Suite Teardown  Terminate All Processes
Test Template   Does RobotLab Load?

*** Test Cases ***
# Chrome   headlesschrome
Firefox  headlessfirefox

*** Keywords ***
Does RobotLab Load?
  [arguments]  ${browser}
  Open RobotLab  ${browser}
  Capture Page Screenshot  00_smoke_test.png
  # Page Should Contain Element   css:.jp-LauncherCard
  # Page Should Contain   Robot Framework
