*** Settings ***
Library  Process
Force Tags  app:nbrobot

*** Test Cases ***
Can I get help on nbrobot?
  ${result} =  Run Keyword If    "${PLATFORM}" == "win32"
  ...   Run Process
  ...   ${ACTIVATE} "${ROBOTLAB DIR}" && nbrobot --help
  ...   shell=True
  ...   ELSE
  ...   Run Process
  ...   source ${ACTIVATE} "${ROBOTLAB DIR}" && nbrobot --help
  ...   shell=True
  Should Be Equal As Numbers    ${result.rc}  251
  ...   msg=Couldn't get help on nbrobot${\n}===${\n}${result.stdout}${\n}===${\n}${result.stderr}
  Should Contain    ${result.stdout}    Robot Framework
