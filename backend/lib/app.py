from server.src.app import create_app


if __name__ == "__main__":
    create_app().run()
    
# from ia.src.main import IA

# while True:
#    detection_data,error =  IA()
#    if error:
#        print(error)
#        break
#    print(detection_data["position_of_square"])