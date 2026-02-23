*** Settings ***
Documentation     Verify Header section elements and navigation
Resource          ../../resources/keywords.robot
Resource          ../../resources/locators.robot


*** Test Cases ***
Verify Header Section And Navigation
    Open MoRent Website
    Verify Header Section Visibility
    Verify Header Navigation Functionality
    Close Browser