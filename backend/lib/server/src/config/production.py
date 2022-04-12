from .config_basis import Config
class Production(Config):
    DEBUG = False
    ENV = "production"