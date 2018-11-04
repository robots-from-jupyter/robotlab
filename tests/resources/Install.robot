*** Settings ***
Library  OperatingSystem
Library  Process
Library  SeleniumLibrary

*** Variables ***
${INSTALLER VERSION}   0.7.0
${INSTALLER DIR}    ${OUTPUT DIR}${/}..${/}..${/}constructor
${INSTALL LOG}     ${OUTPUT DIR}${/}00_installer.log

*** Keywords ***
Clean up the RobotLab installation
  Close All Browsers
  Remove Directory    ${ROBOTLAB DIR}   recursive=True
  Terminate All Processes
  Sleep  5s
  Terminate All Processes  kill=True

Run the RobotLab installer
  ${path} =  Evaluate    __import__("tempfile").mkdtemp("RobotLab")
  ${platform} =  Evaluate  __import__("sys").platform
  Set Global Variable    ${PLATFORM}    ${platform}
  Set Global Variable    ${ROBOTLAB DIR}    ${path}
  ${result} =
  ...  Run Keyword If  "${platform}" == "linux"   Run the RobotLab Linux installer
  ...  ELSE IF   "${platform}" == "win32"   Run the RobotLab Windows Installer
  ...  ELSE IF   "${platform}" == "darwin"   Run the RobotLab OSX Installer
  ...  ELSE      Fatal Error   Can't install on platform ${platform}!
  Should Be Equal as Integers   ${result.rc}    0
  ...  msg=Couldn't complete installer, see ${INSTALL LOG}

Run the RobotLab Linux installer
  [Return]  ${result}
  ${result} =  Run Process
  ...  bash
  ...  ${INSTALLER DIR}${/}RobotLab-${INSTALLER VERSION}-Linux-x86_64.sh
  ...  -fbp   ${ROBOTLAB DIR}
  ...  stdout=${INSTALL LOG}  stderr=STDOUT

Run the RobotLab OSX installer
  [Return]  ${result}
  ${result} =  Run Process
  ...  bash
  ...  ${INSTALLER DIR}${/}RobotLab-${INSTALLER VERSION}-OSX-x86_64.sh
  ...  -fbp   ${ROBOTLAB DIR}
  ...  stdout=${INSTALL LOG}  stderr=STDOUT

Run the RobotLab Windows installer
  [Return]  ${result}
  @{args} =  Set Variable
  ...  /S
  ...  /D=${ROBOTLAB DIR}
  ...  /AddToPath=0
  ...  /RegistyerPython=0
  ...  /InstallationType=JustMe

  ${result} =  Run Process
  ...  ${INSTALLER DIR}${/}RobotLab-${INSTALLER VERSION}-Windows-x86_64.exe
  ...  @{args}
  ...  stdout=${INSTALL LOG}  stderr=STDOUT
