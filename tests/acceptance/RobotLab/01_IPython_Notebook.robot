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
Run Selenium keyword and return status
    [Documentation]
    ...  Run Selenium keyword (optionally with arguments)
    ...  and return status without screenshots on failure
    [Arguments]  ${keyword}  @{arguments}
    ${tmp}=  Register keyword to run on failure  No operation
    ${status}=  Run keyword and return status  ${keyword}  @{arguments}
    Register keyword to run on failure  ${tmp}
    [Return]  ${status}

Can RobotLab make an IPython Notebook?
    [Arguments]    ${browser}
    [Documentation]    Try a basic IPython Notebook
    Set Tags    browser:${browser}
    ${prefix} =    Set Variable    ipython_${browser}_
    Open JupyterLab    browser=${browser}
    ${is_launcher}=  Run Selenium keyword and return status
    ...  Page should contain element
    ...  xpath://div[@class='jp-LauncherCard']
    Run keyword if  not ${is_launcher}
    ...  Execute JupyterLab Command  New Launcher
    Launch a new JupyterLab Document    Python 3    Notebook
    Capture Page Screenshot    ${prefix}_01_notebook.png
    Add and Run JupyterLab Code Cell    print("Hello" + " World")
    Capture Page Screenshot    ${prefix}_02_execute.png
    Sleep    2s
    Wait Until JupyterLab Kernel Is Idle
    Capture Page Screenshot    ${prefix}_03_execute_result.png
    Page Should Contain    Hello World
    Execute JupyterLab Command    Save Notebook
    Sleep    2s
    Capture Page Screenshot    ${prefix}_09_save.png
