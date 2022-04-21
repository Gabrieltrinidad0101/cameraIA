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
                dev = Development()
                env = dev
                return dev
            elif environment == "production":
                pro = Production()
                env = pro
                return pro
            elif environment == "test":
                test = Test()
                env = test
                return test
            else:
                raise Exception("the environment is incorrect")
        except IndexError:
            raise Exception("is the required environment")


    @staticmethod
    def get():
        return env