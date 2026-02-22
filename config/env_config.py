import os


class EnvConfig:
    ROBOT_LIBRARY_SCOPE = 'GLOBAL'

    def __init__(self):
        self.base_url = os.getenv("BASE_URL", "https://morent-car.archisacademy.com/")
        self.browser = os.getenv("BROWSER", "chrome")
        self.default_timeout = os.getenv("DEFAULT_TIMEOUT", "20s")
        self.headless = os.getenv("HEADLESS", "false").lower() == "true"

    def get_base_url(self):
        return self.base_url

    def get_browser(self):
        return self.browser

    def get_default_timeout(self):
        return self.default_timeout

    def is_headless(self):
        return self.headless
