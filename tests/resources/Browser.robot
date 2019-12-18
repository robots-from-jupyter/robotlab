*** Settings ***
Library           JupyterLibrary
Library           OperatingSystem
Resource          Install.robot

*** Variables ***
${NEXT GECKO LOG}    ${0}
${GECKO LOGS}     ${OUTPUT DIR}${/}geckodriver

*** Keywords ***
Open RobotLab
    [Arguments]    ${nbserver}=${None}    ${url}=${EMPTY}    &{configuration}
    [Documentation]    Open RobotLab with the bundled Firefox, served from the
    ...    given (or most-recently-started) ``nbserver`` or ``url``, then wait
    ...    for the splash screen.
    ...    Extra ``configuration`` is passed on to SeleniumLibrary's *Create WebDriver*.
    ${geckodriver} =    Get RobotLab GeckoDriver
    ${firefox} =    Get RobotLab Firefox
    Create Directory    ${GECKO LOGS}
    Create WebDriver    Firefox    executable_path=${geckodriver}    firefox_binary=${firefox}    service_log_path=${GECKO LOGS}${/}${NEXT GECKO LOG}.log    &{configuration}
    Set Global Variable    ${NEXT GECKO LOG}    ${NEXT GECKO LOG.__add__(1)}
    ${nbserver_url} =    Run Keyword If    not "${url}"    Get Jupyter Server URL    ${nbserver}
    ${token} =    Run Keyword If    not "${url}"    Get Jupyter Server Token    ${nbserver}
    Set Global Variable    ${TOKEN}    ${token}
    ${final_url} =    Set Variable If    "${url}"    ${url}    ${nbserver_url}lab?token=${token}
    Go To    about:blank
    Set Window Size    1920    1080
    Go To    ${final_url}
    Wait for JupyterLab Splash Screen

Really Close All Browsers
    [Documentation]    We might open lots of browsers... this might help
    Run keyword And Ignore Error    Handle Alert    timeout=1s
    Run Keyword and Ignore Error    Close All Browsers
    Run keyword And Ignore Error    Handle Alert    timeout=1s
