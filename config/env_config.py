import os

class EnvConfig:
    BASE_URL = os.getenv("BASE_URL", "https://morent-car.archisacademy.com/")
    BROWSER = os.getenv("BROWSER", "chrome")
