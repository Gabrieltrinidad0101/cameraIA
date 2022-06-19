from ipaddress import ip_network
from .development import Development
from .production import Production
from .test import Test

env = {}

class ConfigServer:
    @staticmethod
    def config(environment):
        global env
        try:
            if not (environment in ["development","production","test"]):
                raise Exception("the environment is incorrect")
            if environment == "development":
                env = Development()
            elif environment == "production":
                env = Production()
            elif environment == "test":
                env = Test()
            
            return env
        except IndexError:
            raise Exception("is the required environment")

    def server_url():
        return f"{env.HOST}:{env.PORT}"

    @staticmethod
    def get():
        return env