*** Settings ***
Library           OperatingSystem
Library           Process
Library           SeleniumLibrary

*** Variables ***
${INSTALLER VERSION}    0.7.0
${INSTALLER DIR}    ${OUTPUT DIR}${/}..${/}..${/}constructor
${INSTALL LOG}    ${OUTPUT DIR}${/}00_installer.log

*** Keywords ***
Clean up the RobotLab installation
    Close All Browsers
    Remove Directory    ${ROBOTLAB DIR}    recursive=True
    Terminate All Processes
    Sleep    5s
    Terminate All Processes    kill=True

Run the RobotLab installer
    ${path} =    Evaluate    __import__("tempfile").mkdtemp("RobotLab")
    ${platform} =    Evaluate    __import__("sys").platform
    Set Tags    os:${platform}
    Set Global Variable    ${PLATFORM}    ${platform}
    Set Global Variable    ${ROBOTLAB DIR}    ${path}
    ${result} =    Run Keyword If    "${platform}" == "linux"    Run the RobotLab Linux installer
    ...    ELSE IF    "${platform}" == "win32"    Run the RobotLab Windows Installer
    ...    ELSE IF    "${platform}" == "darwin"    Run the RobotLab OSX Installer
    ...    ELSE    Fatal Error    Can't install on platform ${platform}!
    Should Be Equal as Integers    ${result.rc}    0    msg=Couldn't complete installer, see ${INSTALL LOG}
    File Should Exist    ${ACTIVATE}    msg=Activation script ${ACTIVATE} was not created

Run the RobotLab Linux installer
    ${result} =    Run Process    bash    ${INSTALLER DIR}${/}RobotLab-${INSTALLER VERSION}-Linux-x86_64.sh    -fbp    ${ROBOTLAB DIR}    stdout=${INSTALL LOG}
    ...    stderr=STDOUT
    Set Global Variable    ${ACTIVATE}    ${ROBOTLAB DIR}${/}bin${/}activate
    [Return]    ${result}

Run the RobotLab OSX installer
    ${result} =    Run Process    bash    ${INSTALLER DIR}${/}RobotLab-${INSTALLER VERSION}-OSX-x86_64.sh    -fbp    ${ROBOTLAB DIR}    stdout=${INSTALL LOG}
    ...    stderr=STDOUT
    Set Global Variable    ${ACTIVATE}    ${ROBOTLAB DIR}${/}bin${/}activate
    [Return]    ${result}

Run the RobotLab Windows installer
    ${installer} =    Set Variable    ${INSTALLER DIR}${/}RobotLab-${INSTALLER VERSION}-Windows-x86_64.exe
    ${args} =    Set Variable    /InstallationType=JustMe /AddToPath=0 /RegisterPython=0 /S /D=${ROBOTLAB DIR}
    Log To Console    ${ROBOTLAB DIR}
    ${result} =    Run Process    ${installer} ${args}    stdout=${INSTALL LOG}    stderr=STDOUT    shell=True
    Set Global Variable    ${ACTIVATE}    ${ROBOTLAB DIR}${/}Scripts${/}activate.bat
    [Return]    ${result}
