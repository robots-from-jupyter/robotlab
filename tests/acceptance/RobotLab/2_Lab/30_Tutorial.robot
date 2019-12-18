*** Settings ***
Documentation     Try the Tutorial
Force Tags        starter:tutorial
Library           JupyterLibrary
Resource          ../../../resources/Browser.robot
Resource          ../../../resources/Selectors.robot

*** Variables ***
${TOKEN CELL 00}    .jp-CodeCell:nth-child(3) .CodeMirror

*** Test Cases ***
Will the Tutorial Launch?
    [Documentation]    Start the Tutorial
    Open RobotLab
    ${prefix} =    Set Variable    tutorial_
    Execute JupyterLab Command    Close All
    Wait Until Page Contains Element    ${XP LAUNCH SECTION}
    Capture Page Screenshot    ${prefix}_0_before_starter.png
    Click Element    ${CSS LAUNCH CARD TUTORIAL}
    Wait Until Page Contains Element    ${XP FILE TREE TUTORIAL 00}    timeout=10s
    Capture Page Screenshot    ${prefix}_1_after_starter.png

Will a Tutorial Notebook Run?
    [Documentation]    Run the First Tutorial Notebook
    Open RobotLab
    ${prefix} =    Set Variable    tutorial_00_
    # Set Selenium Speed    0.25s
    Open the Tutorial Folder    ${prefix}
    Open the Tutorial Notebook    ${prefix}
    # TODO: get the url parametrized so that it can also be run
    # Run the Tutorial Notebook    ${prefix}

*** Keywords ***
Open the Tutorial Folder
    [Arguments]    ${prefix}
    [Documentation]    Open the tutorial folder
    Execute JupyterLab Command    Close All
    Maybe Open JupyterLab Sidebar    File Browser
    Click Element    ${CRUMBS HOME}
    Double Click Element    ${XP FILE TREE TUTORIAL}
    Capture Page Screenshot    ${prefix}_1_in_folder.png

Open the Tutorial Notebook
    [Arguments]    ${prefix}
    [Documentation]    Open and prepare the tutorial notebook
    Wait Until Page Contains Element    ${XP FILE TREE TUTORIAL 00}    timeout=10s
    Double Click Element    ${XP FILE TREE TUTORIAL 00}
    Wait Until Page Contains Element    css:.jp-Notebook h2    timeout=10s
    Wait Until Page Contains    Robot Framework | Idle    timeout=3s
    Capture Page Screenshot    ${prefix}_2_after_launch.png
    Execute JupyterLab Command    Clear All Outputs

Run the Tutorial Notebook
    [Arguments]    ${prefix}
    [Documentation]    Actually run the tutorial notebook
    Click Element    css:${TOKEN CELL 00}
    # this gem is because rfjpyl uses backticks...
    Set CodeMirror Value    ${TOKEN CELL 00}    *** Variables ***\n` + '\${token} ' +` ${TOKEN}
    Capture Page Screenshot    ${prefix}_3_after_token.png
    Click Element    ${CSS NOTEBOOK SAVE}
    Execute JupyterLab Command    Run All Cells
    Wait Until Page Does Not Contain    [*]    timeout=20s
    Wait Until Page Contains    Robot Framework | Idle    timeout=3s
    Click Element    ${CSS NOTEBOOK SAVE}
    Execute JupyterLab Command    Close All
