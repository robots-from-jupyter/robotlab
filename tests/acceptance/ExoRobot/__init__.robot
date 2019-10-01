*** Settings ***
Suite Teardown    Clean up the installation
Force Tags        os:${OS}    in-product:${IN_PRODUCT}    product:ExoRobot
Resource          ../../resources/Install.robot
