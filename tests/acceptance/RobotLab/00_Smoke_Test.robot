*** Settings ***
Library  SeleniumLibrary
Resource  ../../resources/Shell.robot
Test Template   Does RobotLab Load?

*** Test Cases ***
Chrome   headlesschrome
Firefox  headlessfirefox

*** Keywords ***
Does RobotLab Load?
  [arguments]  ${browser}
  Open RobotLab  ${browser}
  Capture Page Screenshot  00_smoke_test.png
  # Page Should Contain Element   css:.jp-LauncherCard
  # Page Should Contain   Robot Framework
