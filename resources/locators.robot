*** Settings ***
Documentation     Common locators for MoRent application

*** Variables ***

${LOGIN_BUTTON}            xpath=//button[normalize-space()='Sign in']
${EMAIL_INPUT}             id=identifier-field
${PASSWORD_INPUT}          xpath=//input[@type='password']
${SUBMIT_BUTTON}           css=button.cl-formButtonPrimary
${OTP_INPUT}               xpath=//input[@autocomplete='one-time-code']
${LOGIN_ERROR_MESSAGE}     xpath=//div[contains(@class,'error') or contains(@class,'cl-formFieldErrorText')]
${SIGNOUT_BUTTON}          xpath=//div[contains(@class,'profile')]//button[contains(.,'sign Out') or contains(.,'Logout')]
