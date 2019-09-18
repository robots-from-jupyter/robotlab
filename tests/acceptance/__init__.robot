*** Settings ***
Suite Setup       Set Screenshot Directory    ${OUTPUT DIR}${/}${OS}${/}screenshots
Suite Teardown    Clean up the RobotLab installation
Force Tags        os:${OS}    in-robotlab:${IN_ROBOTLAB}
Resource          ../resources/Install.robot
