*** Settings ***
Resource    ../../resources/keywords.robot

*** Test Cases ***
SG-40 Verify Profile Details Section On Account Page
    Open MoRent Home Page
    Go To Login Page
    Login With Valid Credentials
    Navigate To Account Page
    Close Browser