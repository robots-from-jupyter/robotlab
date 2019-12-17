*** Settings ***
Documentation     robotlab-extension
Force Tags        app:robotlab-extension
Resource          ../../../resources/CLI.robot
Variables         ../../../../scripts/__init__.py
Library           ../../../library/decolorize.py

*** Test Cases ***
Can I list extensions?
    [Documentation]    Does robotlab-extension list work?
    ${output} =  Check a RobotLab CLI command   robotlab-extension list
    Extensions Should Be Installed  ${output}    ${LABEXTENSIONS}

*** Keywords ***
Extensions Should Be Installed
    [Arguments]   ${output}   ${extensions}
    ${cleaned} =   Decolorize   ${output.replace(" ", "")}
    :FOR  ${spec}  IN  @{extensions}
        ${ext} =   Set Variable   ${spec.rsplit('@', 1)}
        Should Contain  ${cleaned}    ${ext[0]}v${ext[1]}enabledOK
    END
