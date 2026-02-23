*** Settings ***
Resource    ../../resources/keywords.robot

*** Test Cases ***
SG-2 Verify Header And Navigation On Home Page
    Open MoRent Home Page
    Verify Header Is Visible
    Verify Header Core Elements
    Verify Header Icons Are Visible
    Verify Sign In Navigation Redirect
    Close Browser