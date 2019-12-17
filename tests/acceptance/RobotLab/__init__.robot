*** Settings ***
Variables         ../../../scripts/__init__.py
Suite Setup       Set Up RobotLab
Suite Teardown    Clean up the RobotLab installation
Force Tags        os:${OS}    in-product:${IN_PRODUCT}    product:RobotLab
Resource          ../../resources/Install.robot
Library           JupyterLibrary

*** Keywords ***
Set Up RobotLab
    Set Screenshot Directory    ${OUTPUT DIR}${/}screenshots

Clean up the RobotLab installation
    [Documentation]    Clean up browser and Jupyter stuff, then the installation
    Close All Browsers
    Terminate All Jupyter Servers
    Clean up the installation
