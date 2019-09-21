*** Settings ***
Documentation     Install RobotLab
Library           OperatingSystem
Library           Process
Library           JupyterLibrary

*** Variables ***
${INSTALLER VERSION}    2019.9.1
${INSTALLER DIR}    ${OUTPUT DIR}${/}..${/}constructor
${INSTALL LOG}    ${OUTPUT DIR}${/}${OS}${/}00_installer.log
&{ROBOTLAB GECKODRIVER}    linux=bin${/}geckodriver    darwin=bin${/}geckodriver    windows=Scripts${/}geckodriver.exe
&{ROBOTLAB FIREFOX}    linux=bin${/}firefox    darwin=bin${/}firefox    windows=Library${/}bin${/}firefox.exe

*** Keywords ***
Clean up the RobotLab installation
    [Documentation]    Clean out the installed RobotLab
    Close All Browsers
    Terminate All Jupyter Servers
    Terminate All Processes
    Sleep    5s
    Terminate All Processes    kill=True
    Run Keyword If    not ${IN_ROBOTLAB}    Remove Directory    ${ROBOTLAB DIR}    recursive=True

Run the RobotLab installer
    [Documentation]    Detect and tag the platform, then run the appropriate installer (if not already in robotlab)
    Create Directory    ${OUTPUT DIR}${/}${OS}
    ${tmpdir} =    Evaluate    ${IN_ROBOTLAB} or __import__("tempfile").mkdtemp("RobotLab")
    ${path} =    Set Variable    ${OUTPUT DIR}${/}${OS}
    ${robotlab dir} =    Set Variable If    ${IN_ROBOTLAB}    %{CONDA_PREFIX}    ${tmpdir}
    Set Global Variable    ${ROBOTLAB DIR}    ${robotlab dir}
    Set Global Variable    ${FAKE HOME}    ${path}${/}home
    Create Directory    ${FAKE HOME}${/}Desktop
    ${rc} =    Run Keyword If    "${OS}" == "linux"    Run the RobotLab Linux installer
    ...    ELSE IF    "${OS}" == "windows"    Run the RobotLab Windows Installer
    ...    ELSE IF    "${OS}" == "darwin"    Run the RobotLab OSX Installer
    ...    ELSE    Fatal Error    Can't install on platform ${OS}!
    Should Be Equal as Integers    ${rc}    0    msg=Couldn't complete installer, see ${INSTALL LOG}
    Wait Until Created    ${ACTIVATE SCRIPT}

Run the RobotLab Linux installer
    [Documentation]    Install RobotLab on Linux
    ${result} =    Run Keyword If    not ${IN_ROBOTLAB}    Run Process    bash    ${INSTALLER DIR}${/}RobotLab-${INSTALLER VERSION}-Linux-x86_64.sh    -fbp
    ...    ${ROBOTLAB DIR}    stdout=${INSTALL LOG}    stderr=STDOUT    env:HOME=${FAKE HOME}
    Set Global Variable    ${ACTIVATE SCRIPT}    ${ROBOTLAB DIR}${/}bin${/}activate
    Set Global Variable    ${ACTIVATE}    set -ex && . "${ACTIVATE SCRIPT}" "${ROBOTLAB DIR}"
    Set Global Variable    ${ROBOTLAB PATH ENV}    ${ROBOTLAB DIR}${/}bin:%{PATH}
    Set Global Variable    ${ROBOTLAB CMD}    ${ROBOTLAB DIR}${/}bin${/}robotlab
    Set Global Variable    ${ROBOTLAB SHORTCUT}    RobotLab.desktop
    ${rc} =    Set Variable If    ${IN_ROBOTLAB}    0    ${result.rc}
    [Return]    ${rc}

Run the RobotLab OSX installer
    [Documentation]    Install RobotLab on OSX
    ${result} =    Run Keyword If    not ${IN_ROBOTLAB}    Run Process    bash    ${INSTALLER DIR}${/}RobotLab-${INSTALLER VERSION}-MacOSX-x86_64.sh    -fbp
    ...    ${ROBOTLAB DIR}    stdout=${INSTALL LOG}    stderr=STDOUT    env:HOME=${FAKE HOME}
    Set Global Variable    ${ACTIVATE SCRIPT}    ${ROBOTLAB DIR}${/}bin${/}activate
    Set Global Variable    ${ACTIVATE}    set -ex && . "${ACTIVATE SCRIPT}" "${ROBOTLAB DIR}"
    Set Global Variable    ${ROBOTLAB PATH ENV}    ${ROBOTLAB DIR}${/}bin${:}%{PATH}
    Set Global Variable    ${ROBOTLAB CMD}    ${ROBOTLAB DIR}${/}bin${/}robotlab
    Set Global Variable    ${ROBOTLAB SHORTCUT}    RobotLab.app
    ${rc} =    Set Variable If    ${IN_ROBOTLAB}    0    ${result.rc}
    [Return]    ${rc}

Run the RobotLab Windows installer
    [Documentation]    Install RobotLab on Windows
    ${installer} =    Set Variable    ${INSTALLER DIR}${/}RobotLab-${INSTALLER VERSION}-Windows-x86_64.exe
    ${args} =    Set Variable    /InstallationType=JustMe /AddToPath=0 /RegisterPython=0 /S /D=${ROBOTLAB DIR}
    ${result} =    Run Keyword If    not ${IN_ROBOTLAB}    Run Process    ${installer} ${args}    stdout=${INSTALL LOG}    stderr=STDOUT
    ...    shell=True    env:HOME=${FAKE HOME}
    Set Global Variable    ${ACTIVATE SCRIPT}    ${ROBOTLAB DIR}${/}Scripts${/}activate.bat
    Set Global Variable    ${ACTIVATE}    "${ACTIVATE SCRIPT}" "${ROBOTLAB DIR}"
    Set Global Variable    ${ROBOTLAB PATH ENV}    ${ROBOTLAB DIR}${:}${ROBOTLAB DIR}${/}Scripts${:}${ROBOTLAB DIR}${/}Library${/}bin${:}%{PATH}
    Set Global Variable    ${ROBOTLAB CMD}    ${ROBOTLAB DIR}${/}Scripts${/}robotlab.exe
    Set Global Variable    ${ROBOTLAB SHORTCUT}    RobotLab.lnk
    ${rc} =    Set Variable If    ${IN_ROBOTLAB}    0    ${result.rc}
    [Return]    ${rc}

Get RobotLab GeckoDriver
    [Documentation]    Get the path to the bundled geckodriver
    [Return]    ${ROBOTLAB DIR}${/}&{ROBOTLAB GECKODRIVER}[${OS}]

Get RobotLab Firefox
    [Documentation]    Get the path to the bundled firefox
    [Return]    ${ROBOTLAB DIR}${/}&{ROBOTLAB FIREFOX}[${OS}]
