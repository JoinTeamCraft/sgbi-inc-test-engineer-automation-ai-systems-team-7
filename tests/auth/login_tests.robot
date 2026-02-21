*** Settings ***
Documentation     Template for Auth tests
Resource          ../../resources/keywords.robot
Resource          ../../resources/locators.robot

*** Test Cases ***
Verify User Can Login With Valid Credentials
    [Documentation]    Validates that a registered user can successfully log in using valid credentials and access the application dashboard.
    [Tags]    auth
    Open Browser To MoRent
    Login With Valid Credentials
    Verify Login Successful
    Close Browser
