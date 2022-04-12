from distutils.debug import DEBUG
from pickle import TRUE
from xml.dom.minidom import parseString
from .config_basis import Config
class Development(Config):
    ENV = "development"
    DEBUG=True