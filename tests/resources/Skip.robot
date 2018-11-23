*** Keywords ***
Maybe Skip
    Run Keyword If    "${PLATFORM}" == "win32" and "${BROWSER}" == "headlesschrome"
    ...  Pass Execution  because Chrome is too old on Azure  skip:chrome-on-windows
