*** Settings ***
Resource    ../../resources/keywords.robot

Suite Setup       Open MoRent Website
Suite Teardown    Close Browser

*** Test Cases ***

Verify Login With Valid Credentials
    Go To Login Page
    Login With Valid Credentials
    Verify User Is Logged In

Verify Login With Invalid Credentials
    Go To Login Page
    Login With Invalid Credentials
    Verify Login Failed
