*** Settings ***
Documentation     Template for common locators
Library           SeleniumLibrary

*** Variables ***
# Add your application locators here
*** Variables ***
${LOGIN_BUTTON}          css=button[class*="signin"]
${EMAIL_INPUT}           id=identifier-field
${PASSWORD_INPUT}        id=password-field
${SUBMIT_BUTTON}         xpath=//*[@id="__next"]/div/div/div/div/div[1]/div[2]/form/button[2]
${LOGOUT_BUTTON}         css=button[class*="signOut"]
