*** Settings ***
Resource    ../../resources/keywords.robot
Resource    ../../resources/locators.robot
Test Setup        Open MoRent Home Page
Test Teardown     Close Browser

*** Test Cases ***
SG-3 Verify User Can Navigate To Sign In Page
    [Documentation]    Validate user navigation from Home page to Sign In page and verify form fields.

    Verify Home Page Loaded Successfully
    Verify Sign In Navigation
    Verify Sign Up Navigation and UI presence