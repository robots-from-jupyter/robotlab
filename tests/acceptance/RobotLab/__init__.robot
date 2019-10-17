*** Settings ***
Suite Setup       Set Screenshot Directory    ${OUTPUT DIR}${/}${OS}${/}screenshots
Suite Teardown    Close All Browsers
Force Tags        os:${OS}    in-product:${IN_PRODUCT}    product:RobotLab
Resource          ../../resources/Install.robot
Library           JupyterLibrary

*** Keywords ***
Clean up the RobotLab installation
    [Documentation]    Clean up browser and Jupyter stuff, then the installation
    Close All Browsers
    Terminate All Jupyter Servers
    Clean up the installation
