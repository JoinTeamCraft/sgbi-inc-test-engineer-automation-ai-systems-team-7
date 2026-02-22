*** Settings ***
Documentation     Template for common locators
Library           SeleniumLibrary

*** Variables ***
${SIGN_IN_BUTTON}               css=button[component='SignInButton']
${EMAIL_IDENTIFIER_FIELD}       css=#identifier-field
${CONTINUE_BTN}                 xpath=//button[@data-localization-key='formButtonPrimary']
${PASSWORD_FIELD}               css=#password-field
${PROFILE_ICON}                 css=div[data-clerk-component$='UserButton']
${MANAGE_ACCOUNT}               xpath=//button[normalize-space()='Manage account']
${ACCOUNT_MODAL}                xpath=//div[@role='dialog' and not(@aria-hidden='true')]
${PROFILE_DETAIL}               xpath=//div[@role='dialog']//h1[normalize-space()='Profile details']
${MANAGE_YOUR_ACCOUNT}          xpath=//div[@role='dialog']//p[contains(.,'Manage your account')]
${SIDEBAR_PROFILE_OPTION}       xpath=//div[@role='dialog']//span[normalize-space()='Profile']
${SIDEBAR_SECURITY_OPTION}      xpath=//div[@role='dialog']//span[normalize-space()='Security']
