*** Settings ***
Suite Setup       Set Screenshot Directory    ${OUTPUT DIR}${/}screenshots
Suite Teardown    Clean up the RobotLab installation
Force Tags        os:${OS}    in-product:${IN_PRODUCT}    product:RobotLab
Variables         ../../../scripts/__init__.py
Resource          ../../resources/Install.robot
Library           JupyterLibrary

*** Keywords ***
Clean up the RobotLab installation
    [Documentation]    Clean up browser and Jupyter stuff, then the installation
    Close All Browsers
    Terminate All Jupyter Servers
    Clean up the installation
