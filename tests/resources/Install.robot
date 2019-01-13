*** Settings ***
Documentation     Install RobotLab
Library           OperatingSystem
Library           Process
Library           JupyterLibrary

*** Variables ***
${INSTALLER VERSION}    0.10.2
${INSTALLER DIR}    ${OUTPUT DIR}${/}..${/}constructor
${INSTALL LOG}    ${OUTPUT DIR}${/}${OS}${/}00_installer.log

*** Keywords ***
Clean up the RobotLab installation
    [Documentation]    Clean out the installed RobotLab
    Close All Browsers
    Terminate All Jupyter Servers
    Remove Directory    ${ROBOTLAB DIR}    recursive=True
    Terminate All Processes
    Sleep    5s
    Terminate All Processes    kill=True

Run the RobotLab installer
    [Documentation]    Detect and tag the platform, then run the appropriate installer
    ${path} =    Evaluate    __import__("tempfile").mkdtemp("RobotLab")
    Create Directory    ${OUTPUT DIR}${/}${OS}
    Set Global Variable    ${ROBOTLAB DIR}    ${path}${/}robotlab
    Set Global Variable    ${FAKE HOME}  ${path}${/}home
    Create Directory    ${FAKE HOME}${/}Desktop
    ${result} =    Run Keyword If    "${OS}" == "linux"    Run the RobotLab Linux installer
    ...    ELSE IF    "${OS}" == "windows"    Run the RobotLab Windows Installer
    ...    ELSE IF    "${OS}" == "darwin"    Run the RobotLab OSX Installer
    ...    ELSE    Fatal Error    Can't install on platform ${OS}!
    Should Be Equal as Integers    ${result.rc}    0    msg=Couldn't complete installer, see ${INSTALL LOG}
    File Should Exist    ${ACTIVATE SCRIPT}    msg=Activation script ${ACTIVATE SCRIPT} was not created

Run the RobotLab Linux installer
    [Documentation]    Install RobotLab on Linux
    ${result} =    Run Process    bash    ${INSTALLER DIR}${/}RobotLab-${INSTALLER VERSION}-Linux-x86_64.sh    -fbp    ${ROBOTLAB DIR}    stdout=${INSTALL LOG}
    ...    stderr=STDOUT   env:HOME=${FAKE HOME}
    Set Global Variable    ${ACTIVATE SCRIPT}    ${ROBOTLAB DIR}${/}bin${/}activate
    Set Global Variable    ${ACTIVATE}    set -eux && . "${ACTIVATE SCRIPT}" "${ROBOTLAB DIR}"
    Set Global Variable    ${ROBOTLAB PATH ENV}    ${ROBOTLAB DIR}${/}bin:%{PATH}
    Set Global Variable    ${ROBOTLAB CMD}    ${ROBOTLAB DIR}${/}bin${/}robotlab
    Set Global Variable    ${ROBOTLAB SHORTCUT}    RobotLab.desktop
    [Return]    ${result}

Run the RobotLab OSX installer
    [Documentation]    Install RobotLab on OSX
    ${result} =    Run Process    bash    ${INSTALLER DIR}${/}RobotLab-${INSTALLER VERSION}-MacOSX-x86_64.sh    -fbp    ${ROBOTLAB DIR}    stdout=${INSTALL LOG}
    ...    stderr=STDOUT   env:HOME=${FAKE HOME}
    Set Global Variable    ${ACTIVATE SCRIPT}    ${ROBOTLAB DIR}${/}bin${/}activate
    Set Global Variable    ${ACTIVATE}    set -eux && . "${ACTIVATE SCRIPT}" "${ROBOTLAB DIR}"
    Set Global Variable    ${ROBOTLAB PATH ENV}    ${ROBOTLAB DIR}${/}bin${:}%{PATH}
    Set Global Variable    ${ROBOTLAB CMD}    ${ROBOTLAB DIR}${/}bin${/}robotlab
    Set Global Variable    ${ROBOTLAB SHORTCUT}    RobotLab.app
    [Return]    ${result}

Run the RobotLab Windows installer
    [Documentation]    Install RobotLab on Windows
    ${installer} =    Set Variable    ${INSTALLER DIR}${/}RobotLab-${INSTALLER VERSION}-Windows-x86_64.exe
    ${args} =    Set Variable    /InstallationType=JustMe /AddToPath=0 /RegisterPython=0 /S /D=${ROBOTLAB DIR}
    ${result} =    Run Process    ${installer} ${args}    stdout=${INSTALL LOG}    stderr=STDOUT    shell=True    env:HOME=${FAKE HOME}
    Set Global Variable    ${ACTIVATE SCRIPT}    ${ROBOTLAB DIR}${/}Scripts${/}activate.bat
    Set Global Variable    ${ACTIVATE}    "${ACTIVATE SCRIPT}" "${ROBOTLAB DIR}"
    Set Global Variable    ${ROBOTLAB PATH ENV}    ${ROBOTLAB DIR}${:}${ROBOTLAB DIR}${/}Scripts${:}${ROBOTLAB DIR}${/}Library${/}bin${:}%{PATH}
    Set Global Variable    ${ROBOTLAB CMD}    ${ROBOTLAB DIR}${/}Scripts${/}robotlab.exe
    Set Global Variable    ${ROBOTLAB SHORTCUT}    RobotLab.lnk
    [Return]    ${result}
