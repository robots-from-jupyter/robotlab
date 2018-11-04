*** Settings ***
Library  SeleniumLibrary

*** Keywords ***
Open RobotLab
  [Arguments]  ${browser}
  Should Not Be Empty    ${LAB URL}    msg=Needs a configured RobotLab server
  Set Screenshot Directory  ${OUTPUT DIR}${/}${browser}
  Open Browser    ${LAB URL}  ${browser}
  Wait for Splash Screen

Wait for Splash Screen
  [Documentation]    Wait for the JupyterLab splash animation to run its course
  Wait Until Page Contains Element    ${SPLASH ID}
  Wait Until Page Does Not Contain Element    ${SPLASH ID}
  Sleep    0.1s

*** Variables ***
${SPLASH ID}      jupyterlab-splash
