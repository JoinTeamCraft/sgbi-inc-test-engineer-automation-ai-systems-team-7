*** Settings ***
Documentation     Validates successful user registration with valid inputs and UI success behavior.
Resource          ../../resources/keywords.robot
Resource          ../../resources/locators.robot
Test Setup        Open MoRent Home Page
Test Teardown     Close Browser

*** Test Cases ***
Registration Should Succeed With Valid Required Fields
    [Documentation]    Submits valid sign-up details, verifies success state, pauses for manual OTP, then verifies final redirect.
    [Tags]    auth    signup    positive    manual_otp
    Go To Sign Up Page

    ${email}=    Build Repeatable Registration Email
    Fill Valid Registration Details    ${email}

    Submit Registration Form Handling Human Check
    Assert No Visible Registration Errors
    Wait For Registration Success Indicator

    Pause For Manual OTP Completion
    Verify Redirected To Login Or Home Page
