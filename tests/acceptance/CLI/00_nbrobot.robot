*** Settings ***
Library  Process
Force Tags  app:nbrobot

*** Test Cases ***
Can I get help on nbrobot?
  ${proc} =  Run Keyword If    "${PLATFORM}" == "win32"
  ...   Start Process
  ...   ${ACTIVATE} "${ROBOTLAB DIR}" && nbrobot --help
  ...   shell=True
  ...   ELSE
  ...   Start Process
  ...   source ${ACTIVATE} "${ROBOTLAB DIR}" && nbrobot --help
  ...   shell=True
  Sleep  3s
  Process Should Be Stopped  ${proc}
  ...   msg=${\n}${proc.stdout}${\n}===${\n}${proc.stderr}
  Should Be Equal As Numbers    ${proc.rc}  251
  ...   msg=${\n}${proc.stdout}${\n}===${\n}${proc.stderr}
  Should Contain    ${proc.stdout}    Robot Framework
