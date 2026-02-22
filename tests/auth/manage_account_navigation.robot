*** Settings ***
Resource    ../../resources/keywords.robot

*** Test Cases ***
Verify User Can Open Manage Account Modal From Profile Dropdown
    [Documentation]    Validates that clicking on Manage Account from the profile dropdown opens the Account modal with correct content.
    [Tags]    auth    account

    Open Browser To MoRent
    Login With Valid Credentials
    Open Profile Dropdown
    Click Manage Account
    Verify Manage Account Modal Is Open
    Close Browser

