*** Settings ***
Documentation     Try the Examples
Force Tags        starter:example
Library           JupyterLibrary
Resource          ../../../resources/Browser.robot
Resource          ../../../resources/Lab.robot
Resource          ../../../resources/Selectors.robot

*** Variables ***
${KERNEL LANGUAGE}    Robot Framework

*** Test Cases ***
Will the Example Starter Launch?
    [Documentation]    Start the Example
    [Tags]    example:opencv
    Open RobotLab
    ${prefix} =    Set Variable    example_
    Execute JupyterLab Command    Close All
    Wait Until Page Contains Element    ${XP LAUNCH SECTION}
    Capture Page Screenshot    ${prefix}_0_before_starter.png
    Click Element    ${CSS LAUNCH CARD EXAMPLES}
    Wait Until Page Contains Element    ${XP FILE TREE EXAMPLE OPENCV}    timeout=10s
    Capture Page Screenshot    ${prefix}_1_after_starter.png

Will the OpenCV Notebook Run?
    [Documentation]    Run the OpenCV Tutorial Notebook
    [Tags]    example:opencv
    Open RobotLab
    ${prefix} =    Set Variable    example_opencv_
    Open the Example Folder    ${prefix}
    Open the Example Notebook    ${prefix}    ${XP FILE TREE EXAMPLE OPENCV}
    Run the Example Notebook    ${prefix}
    Capture Page Screenshot    ${prefix}_6_after_run_all.png
    The Robot Popup Should Contain    ${prefix}    Log    passed, 0 failed
    The Robot Popup Should Contain    ${prefix}    Report    All tests passed
    Capture Page Screenshot    ${prefix}_7_reported.png
    Screenshot Each Output of Active JupyterLab Document    ${prefix}_8_all_

*** Keywords ***
Open the Example Folder
    [Arguments]    ${prefix}
    [Documentation]    Open the example folder
    Execute JupyterLab Command    Close All
    Maybe Open JupyterLab Sidebar    File Browser
    Click Element    ${CRUMBS HOME}
    Double Click Element    ${XP FILE TREE EXAMPLE}
    Capture Page Screenshot    ${prefix}_1_in_folder.png

Open the Example Notebook
    [Arguments]    ${prefix}    ${example}
    [Documentation]    Open and prepare the example notebook
    Wait Until Page Contains Element    ${example}    timeout=10s
    Double Click Element    ${example}
    Wait Until Page Contains    ${KERNEL LANGUAGE} | Idle    timeout=10s
    Capture Page Screenshot    ${prefix}_2_after_launch.png
    Execute JupyterLab Command    Clear All Outputs
    Sleep    1s
    Capture Page Screenshot    ${prefix}_3_after_clean.png

Run the Example Notebook
    [Arguments]    ${prefix}
    [Documentation]    Actually run the example notebook
    Execute JupyterLab Command    Run All Cells
    Wait Until Page Does Not Contain    [*]    timeout=120s
    Wait Until Page Contains    ${KERNEL LANGUAGE} | Idle    timeout=120s
    Capture Page Screenshot    ${prefix}_4_after_run.png
