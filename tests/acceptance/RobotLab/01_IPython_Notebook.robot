*** Settings ***
Documentation     Try out some browsers with RobotLab Notebooks
Test Template     Can RobotLab make an IPython Notebook?
Library           JupyterLibrary

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
    Open JupyterLab    browser=${browser}
    # Try to work around possible issue that JupyterLibrary does not wait
    Wait until page contains element    xpath://div[@class='jp-LauncherCard']
    Launch a new JupyterLab Document    Python 3    Notebook
    Capture Page Screenshot    ${prefix}_01_notebook.png
    Add and Run JupyterLab Code Cell    print("Hello" + " World")
    Capture Page Screenshot    ${prefix}_02_execute.png
    Sleep  3s
    Wait Until JupyterLab Kernel Is Idle
    Capture Page Screenshot    ${prefix}_03_execute_result.png
    Page Should Contain    Hello World
    Execute JupyterLab Command    Save Notebook
    Capture Page Screenshot    ${prefix}_09_save.png
