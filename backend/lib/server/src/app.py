from dotenv import load_dotenv
from flask import Flask,request,Response
load_dotenv()



def create_app():
    app = Flask(__name__)
    return app
