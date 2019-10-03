*** Settings ***
Documentation     Install a Product
Library           OperatingSystem
Library           Process

*** Variables ***
${INSTALLER VERSION}    2019.9.1
${INSTALL LOG}    ${OUTPUT DIR}${/}${OS}${/}00_installer.log
&{GECKODRIVER}    linux=bin${/}geckodriver    darwin=bin${/}geckodriver    windows=Scripts${/}geckodriver.exe
&{FIREFOX}        linux=bin${/}firefox    darwin=bin${/}firefox    windows=Library${/}bin${/}firefox.exe

*** Keywords ***
Clean up the installation
    [Documentation]    Clean out the installed product
    Terminate All Processes
    Sleep    5s
    Terminate All Processes    kill=True
    Sleep    5s
    Run Keyword If    not ${IN_PRODUCT}    Remove Directory    ${PRODUCT DIR}    recursive=True
    Sleep    5s
    Run Keyword If    not ${IN_PRODUCT}    Remove Directory    ${PRODUCT DIR}    recursive=True

Run the installer
    [Arguments]    ${product}
    [Documentation]    Detect and tag the platform, then run the appropriate installer (if not already in robotlab)
    Create Directory    ${OUTPUT DIR}${/}${OS}
    ${tmpdir} =    Evaluate    ${IN_PRODUCT} or __import__("tempfile").mkdtemp("RobotLab")
    ${path} =    Set Variable    ${OUTPUT DIR}${/}${OS}
    ${product dir} =    Set Variable If    ${IN_PRODUCT}    %{CONDA_PREFIX}    ${tmpdir}
    Set Global Variable    ${PRODUCT DIR}    ${product dir}
    Set Global Variable    ${FAKE HOME}    ${path}${/}home
    Create Directory    ${FAKE HOME}${/}Desktop
    ${rc} =    Run Keyword If    "${OS}" == "linux"    Run the Linux Installer    ${product}
    ...    ELSE IF    "${OS}" == "windows"    Run the Windows Installer    ${product}
    ...    ELSE IF    "${OS}" == "darwin"    Run the OSX Installer    ${product}
    ...    ELSE    Fatal Error    Can't install on platform ${OS}!
    Should Be Equal as Integers    ${rc}    0    msg=Couldn't complete installer, see ${INSTALL LOG}
    Wait Until Created    ${ACTIVATE SCRIPT}

Run the Linux installer
    [Arguments]    ${product}
    [Documentation]    Install on Linux
    ${result} =    Run Keyword If    not ${IN_PRODUCT}    Run Process    bash    ${INSTALLER DIR}${/}${product}-${INSTALLER VERSION}-Linux-x86_64.sh    -fbp
    ...    ${PRODUCT DIR}    stdout=${INSTALL LOG}    stderr=STDOUT    env:HOME=${FAKE HOME}
    Set Global Variable    ${ACTIVATE SCRIPT}    ${PRODUCT DIR}${/}bin${/}activate
    Set Global Variable    ${ACTIVATE}    set -ex && . "${ACTIVATE SCRIPT}" "${PRODUCT DIR}"
    Set Global Variable    ${PRODUCT PATH ENV}    ${PRODUCT DIR}${/}bin:%{PATH}
    Run Keyword If    "${product}" == "RobotLab"    Set Global Variable    ${ROBOTLAB CMD}    ${PRODUCT DIR}${/}bin${/}robotlab
    Run Keyword If    "${product}" == "RobotLab"    Set Global Variable    ${ROBOTLAB SHORTCUT}    RobotLab.desktop
    ${rc} =    Set Variable If    ${IN_PRODUCT}    0    ${result.rc}
    [Return]    ${rc}

Run the OSX installer
    [Arguments]    ${product}
    [Documentation]    Install on OSX
    ${result} =    Run Keyword If    not ${IN_PRODUCT}    Run Process    bash    ${INSTALLER DIR}${/}${product}-${INSTALLER VERSION}-MacOSX-x86_64.sh    -fbp
    ...    ${PRODUCT DIR}    stdout=${INSTALL LOG}    stderr=STDOUT    env:HOME=${FAKE HOME}
    Set Global Variable    ${ACTIVATE SCRIPT}    ${PRODUCT DIR}${/}bin${/}activate
    Set Global Variable    ${ACTIVATE}    set -ex && . "${ACTIVATE SCRIPT}" "${PRODUCT DIR}"
    Set Global Variable    ${PRODUCT PATH ENV}    ${PRODUCT DIR}${/}bin${:}%{PATH}
    Run Keyword If    "${product}" == "RobotLab"    Set Global Variable    ${ROBOTLAB CMD}    ${PRODUCT DIR}${/}bin${/}robotlab
    Run Keyword If    "${product}" == "RobotLab"    Set Global Variable    ${ROBOTLAB SHORTCUT}    RobotLab.app
    ${rc} =    Set Variable If    ${IN_PRODUCT}    0    ${result.rc}
    [Return]    ${rc}

Run the Windows installer
    [Arguments]    ${product}
    [Documentation]    Install on Windows
    ${installer} =    Set Variable    ${INSTALLER DIR}${/}${product}-${INSTALLER VERSION}-Windows-x86_64.exe
    ${args} =    Set Variable    /InstallationType=JustMe /AddToPath=0 /RegisterPython=0 /S /D=${PRODUCT DIR}
    ${result} =    Run Keyword If    not ${IN_PRODUCT}    Run Process    ${installer} ${args}    stdout=${INSTALL LOG}    stderr=STDOUT
    ...    shell=True    env:HOME=${FAKE HOME}
    Set Global Variable    ${ACTIVATE SCRIPT}    ${PRODUCT DIR}${/}Scripts${/}activate.bat
    Set Global Variable    ${ACTIVATE}    "${ACTIVATE SCRIPT}" "${PRODUCT DIR}"
    Set Global Variable    ${PRODUCT PATH ENV}    ${PRODUCT DIR}${:}${PRODUCT DIR}${/}Scripts${:}${PRODUCT DIR}${/}Library${/}bin${:}%{PATH}
    Run Keyword If    "${product}" == "RobotLab"    Set Global Variable    ${ROBOTLAB CMD}    ${PRODUCT DIR}${/}Scripts${/}robotlab.exe
    Run Keyword If    "${product}" == "RobotLab"    Set Global Variable    ${ROBOTLAB SHORTCUT}    RobotLab.lnk
    ${rc} =    Set Variable If    ${IN_PRODUCT}    0    ${result.rc}
    [Return]    ${rc}

Get RobotLab GeckoDriver
    [Documentation]    Get the path to the bundled geckodriver
    [Return]    ${PRODUCT DIR}${/}&{GECKODRIVER}[${OS}]

Get RobotLab Firefox
    [Documentation]    Get the path to the bundled firefox
    [Return]    ${PRODUCT DIR}${/}&{FIREFOX}[${OS}]
