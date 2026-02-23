*** Settings ***
Resource    ../../resources/keywords.robot

*** Test Cases ***
SG-3 Verify Navigation To Registration Page
    Open MoRent Home Page
    Verify Sign In Navigation
    Verify Registration Page Navigation
    Verify Registration Form Fields Are Visible
    Close Browser