*** Settings ***
Resource    ../../resources/keywords.robot

*** Test Cases ***
SG-2 Verify Header And Navigation On Home Page
    Open MoRent Home Page
    Verify Header Is Visible
    Verify Header Elements Are Visible
    Verify Search Bar Is Clickable
    Verify Logo Navigation
    Verify Header Navigation Links Redirect Correctly
    Verify Sign In Navigation
    Close Browser