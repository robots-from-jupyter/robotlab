*** Settings ***
Suite Teardown    Clean up the RobotLab installation
Force Tags        os:${OS}
Resource          ../resources/Install.robot
