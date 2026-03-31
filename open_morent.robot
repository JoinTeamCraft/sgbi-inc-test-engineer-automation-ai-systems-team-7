*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${URL}        https://morent-car.archisacademy.com/
${BROWSER}    chrome


*** Test Cases ***
Verify Desktop Navigation Behaviour
    # ---- Launch Website ----
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Wait Until Page Contains Element    xpath=//header    15s

    # ---- Verify Header Elements ----
    Element Should Be Visible    xpath=//header
    Element Should Be Visible    xpath=//span[contains(text(),'MORENT')]
    Element Should Be Visible    xpath=//header//*[contains(@class,'header-right')]

    # ---- Favorites ----
    Click Element    xpath=(//header//*[contains(@class,'header-right')]//*[name()='svg'])[1]
    Wait Until Element Is Visible    xpath=//button[.//span[normalize-space()='Sign In']]    10s
    Click Element    xpath=//button[.//span[normalize-space()='Sign In']]

    # ---- Orders ----
    Click Element    xpath=(//header//*[contains(@class,'header-right')]//*[name()='svg'])[2]
    Wait Until Element Is Visible    xpath=//button[.//span[normalize-space()='Sign In']]    10s
    Click Element    xpath=//button[.//span[normalize-space()='Sign In']]

    # ---- Settings ----
    Click Element    xpath=(//header//*[contains(@class,'header-right')]//*[name()='svg'])[3]
    Sleep    2s
    Page Should Contain Element    xpath=//header

    Close Browser