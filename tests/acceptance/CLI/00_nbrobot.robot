*** Settings ***
Library  Process
Library  OperatingSystem
Force Tags  app:nbrobot

*** Test Cases ***
Can I get help on nbrobot?
  ${log} =  Set Variable  ${OUTPUT DIR}${/}nbrobot.log
  ${proc} =  Run Keyword If    "${PLATFORM}" == "win32"
  ...   Run Process
  ...   ${ACTIVATE} "${ROBOTLAB DIR}" && nbrobot --help
  ...   shell=True  stdout=${log}  stderr=STDOUT  timeout=3s
  ...   ELSE
  ...   Run Process
  ...   source ${ACTIVATE} "${ROBOTLAB DIR}" && nbrobot --help
  ...   shell=True  stdout=${log}  stderr=STDOUT  timeout=3s
  Should Be Equal As Numbers    ${proc.rc}  251
  ${log text} =  Get File  ${log}
  Should Contain    ${log text}    Robot Framework
