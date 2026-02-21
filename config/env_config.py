import os

class EnvConfig:
    """Environment configuration helper exposed to Robot Framework."""

    ROBOT_LIBRARY_SCOPE = "GLOBAL"

    def get_config_value(self, key, default=""):
        """Return a configuration value from environment variables."""
        return os.getenv(key, default)

    def get_base_url(self):
        """Return AUT base URL, with sensible default for this project."""
        return os.getenv("MORENT_BASE_URL", "https://morent-car.archisacademy.com/")

    def get_browser(self):
        """Return browser name used by SeleniumLibrary."""
        return os.getenv("BROWSER", "chrome")

    def get_default_timeout(self):
        """Return default wait timeout for Robot keywords."""
        return os.getenv("DEFAULT_TIMEOUT", "20s")


_env = EnvConfig()


def get_config_value(key, default=""):
    return _env.get_config_value(key, default)


def get_base_url():
    return _env.get_base_url()


def get_browser():
    return _env.get_browser()


def get_default_timeout():
    return _env.get_default_timeout()
