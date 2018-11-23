*** Keywords ***
Maybe Skip
    [Documentation]    Potentially pass execution for various reasons
    Pass Execution If    "${PLATFORM}" == "win32" and "${BROWSER}" == "headlesschrome"    because Chrome is too old on Azure    skip:chrome-on-windows
