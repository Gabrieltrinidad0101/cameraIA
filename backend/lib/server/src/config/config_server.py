from .development import Development
from .production import Production
from .test import Test

env = {}

class ConfigServer:
    @staticmethod
    def config(environment):
        global env
        try:
            if environment == "development":
                env = Development()
                return env
            elif environment == "production":
                env = Production()
                return env
            elif environment == "test":
                env = Test()
                return env
            else:
                raise Exception("the environment is incorrect")
        except IndexError:
            raise Exception("is the required environment")


    @staticmethod
    def get():
        return env