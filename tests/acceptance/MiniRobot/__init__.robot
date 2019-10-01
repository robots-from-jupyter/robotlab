*** Settings ***
Suite Teardown    Clean up the installation
Force Tags        os:${OS}    in-product:${IN_PRODUCT}    product:MiniRobot
Resource          ../../resources/Install.robot
