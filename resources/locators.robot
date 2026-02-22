*** Settings ***
Documentation     Common locators for MoRent
Library           SeleniumLibrary

*** Variables ***
${LOGIN_BUTTON}     xpath=//button[normalize-space()='Sign in']
${EMAIL_INPUT}      id=identifier-field
${PASSWORD_INPUT}   xpath=//input[@type='password']
${SUBMIT_BUTTON}    css=button.cl-formButtonPrimary
${OTP_INPUT}        xpath=//input[@autocomplete='one-time-code']
${LOGOUT_BUTTON}    xpath=//button[contains(.,'Continue') or contains(.,'Verify')]
