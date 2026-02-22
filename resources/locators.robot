*** Variables ***
${LOGIN_BUTTON}          xpath=//button[contains(text(),'Login')]
${EMAIL_INPUT}           id=email
${PASSWORD_INPUT}        xpath=//input[@type='password']
${SUBMIT_BUTTON}         css=button.cl-formButtonPrimary
${OTP_INPUT}             xpath=//input[@autocomplete='one-time-code']

# Post Login Elements ⭐
${PROFILEICON_BUTTON}    xpath=//div[contains(@class,'profile')] | //img[contains(@class,'avatar')]
${SIGNOUT_BUTTON}        xpath=//button[normalize-space()='sign Out' or normalize-space()='Logout']
