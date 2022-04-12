import sys
from .development import Development
from .production import Production
from .test import Test
class ConfigServer:
    @staticmethod
    def config() -> None:
        try:
            environment = sys.argv[1]
            if environment == "development":
                return Development()
            elif environment == "production":
                return Production()
            elif environment == "test":
                return Test()
            else:
                raise Exception("the environment is incorrect")
        except IndexError:
            raise Exception("is the required environment")

