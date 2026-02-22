from config.env_config import EnvConfig

class EnvLibrary:

    def get_base_url(self):
        return EnvConfig.BASE_URL

    def get_browser(self):
        return EnvConfig.BROWSER
