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
  Page Should Contain   Robot Framework
  Capture Page Screenshot  00_smoke_test.png
