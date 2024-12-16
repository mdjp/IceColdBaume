import RPi.GPIO as GPIO
import time
from threading import Thread
from time import sleep

GPIO.setmode(GPIO.BCM)
GPIO.setwarnings(False)
GPIO.setup(21,GPIO.OUT)


run = True;

def threaded_function():
    while True:
        with open("lightswitch.dat") as f:
            s = f.read()
            print(s)
        if s == '1':
            print("LED on")
            GPIO.output(21,GPIO.HIGH)
            time.sleep(1)
            print ("LED off")
            GPIO.output(21,GPIO.LOW)
            time.sleep(1)
        else:
            GPIO.output(21,GPIO.LOW)


if __name__ == "__main__":
    thread = Thread(target = threaded_function, args = ())
    thread.start()
