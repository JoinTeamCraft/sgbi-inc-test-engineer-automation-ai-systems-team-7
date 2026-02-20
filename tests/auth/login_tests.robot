*** Settings ***
Documentation     SG-7 - Verify login with valid credential
Library           SeleniumLibrary
Resource          ../../resources/keywords.robot
Resource          ../../resources/locators.robot
Suite Setup       Open MoRent Website
Suite Teardown    Close Browser
*** Test Cases ***
Verify Login With Valid Credentials
    Click Login Button
    Enter Email And Continue
    Enter Password And Continue
    Handle OTP If Present
    Verify Successful Login
