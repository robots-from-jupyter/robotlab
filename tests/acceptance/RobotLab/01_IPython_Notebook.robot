*** Settings ***
Documentation     Try out some browsers with RobotLab Notebooks
Test Template     Can RobotLab make an IPython Notebook?
Library           SeleniumLibrary
Resource          ../../resources/Launch.robot
Resource          ../../resources/Shell.robot
Resource          ../../resources/Notebook.robot

*** Test Cases ***
Chrome
    headlesschrome

Firefox
    headlessfirefox

*** Keywords ***
Can RobotLab make an IPython Notebook?
    [Arguments]    ${browser}
    [Documentation]    Try a basic IPython Notebook
    Set Tags    browser:${browser}
    ${prefix} =    Set Variable    ipython_${browser}_
    Open RobotLab    ${browser}
    Launch a new    Python 3    Notebook
    Capture Page Screenshot    ${prefix}_01_notebook.png
    Add and Run Cell    print("Hello" + " World")
    Capture Page Screenshot    ${prefix}_02_execute.png
    Wait Until Kernel Is Idle
    Capture Page Screenshot    ${prefix}_03_execute_result.png
    Page Should Contain    Hello World
    Execute JupyterLab Command    Save Notebook
    Capture Page Screenshot    ${prefix}_09_save.png
