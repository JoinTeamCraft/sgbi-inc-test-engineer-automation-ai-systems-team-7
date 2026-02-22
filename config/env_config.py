import os

ROBOT_LIBRARY_SCOPE = 'GLOBAL'

def get_test_email():
    return os.getenv("TEST_EMAIL")

def get_test_password():
    return os.getenv("TEST_PASSWORD")

def get_otp_code():
    return os.getenv("OTP_CODE")
