*** Settings ***
Documentation     Verify MoRent application launch
Resource          ../../resources/keywords.robot
Resource          ../../resources/locators.robot
Resource          ../../resources/test_data.robot

*** Test Cases ***
Verify MoRent Application Launch
    Open Browser To MoRent
    Verify Home Page Loaded Successfully
    Close Browser