from datetime import datetime


class Validators:
    """Validation and test-data helpers exposed to Robot Framework."""

    ROBOT_LIBRARY_SCOPE = "GLOBAL"

    def get_invalid_email_inputs(self):
        """Return known-invalid email samples for sign-up validation tests."""
        return ["user@", "user.com", "user@domain"]

    def get_invalid_password_inputs(self):
        """Return known-invalid password samples for sign-up validation tests."""
        return ["123", "password", "12345678"]

    def build_unique_email(self, prefix="test.user"):
        """Return a unique email for repeated test execution."""
        stamp = datetime.utcnow().strftime("%Y%m%d%H%M%S%f")
        clean_prefix = str(prefix).replace(" ", ".").lower()
        return f"{clean_prefix}.{stamp}@gmail.com"


_validators = Validators()


def get_invalid_email_inputs():
    return _validators.get_invalid_email_inputs()


def get_invalid_password_inputs():
    return _validators.get_invalid_password_inputs()


def build_unique_email(prefix="test.user"):
    return _validators.build_unique_email(prefix)
