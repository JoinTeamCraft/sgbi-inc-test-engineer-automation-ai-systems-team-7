*** Settings ***
Resource         ../../resources/keywords.robot
Test Setup       Setup And Login
Test Teardown    Close Browser

*** Test Cases ***
SG-42 Update Profile Picture Verification
    Open Update Profile Modal
    Upload New Profile Picture
    Click Element    ${PROFILE_ICON}
    Wait Until Element Is Visible    ${HEADER_PROFILE_AVATAR}    10s
    Element Should Be Visible        ${HEADER_PROFILE_AVATAR}