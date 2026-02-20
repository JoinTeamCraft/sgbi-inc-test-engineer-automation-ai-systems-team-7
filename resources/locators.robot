*** Settings ***
Documentation     Template for common locators
Library           SeleniumLibrary

*** Variables ***
# Add your application locators here
*** Variables ***
${LOGIN_BUTTON}          css=button[class*="signIn"]
${EMAIL_INPUT}           id=identifier-field
${PASSWORD_INPUT}        id=password-field
${SUBMIT_BUTTON}         css=button[class*=formButtonPrimary]
${LOGOUT_BUTTON}         css=button[class*="signOut"]
