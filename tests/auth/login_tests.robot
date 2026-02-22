*** Settings ***
Resource    ../../resources/keywords.robot
Resource    ../../resources/locators.robot

Suite Setup     Open MoRent Website
Suite Teardown  Close Browser

*** Test Cases ***

Invalid Login Test
    Go To Login Page
    Login With Invalid Credentials
    Verify Login Failed
