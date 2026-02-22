*** Settings ***
Resource    ../../resources/keywords.robot

*** Test Cases ***
Verify Login With Valid Credentials
    Open MoRent Website
    Go To Login Page
    Login With Valid Credentials
    Verify User Is Logged In
