from .config_basis import Config

class Development(Config):
    ENV = "development"
    FLASK_DEBUG = True
    DEBUG = True