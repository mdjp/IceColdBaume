import RPi.GPIO as GPIO
import time
from pynput.keyboard import Key, Controller
from threading import Thread
from time import sleep

keyboard = Controller()

GPIO.setmode(GPIO.BCM)
GPIO.setup(22, GPIO.IN, pull_up_down=GPIO.PUD_UP)
GPIO.setup(23, GPIO.IN, pull_up_down=GPIO.PUD_UP)
GPIO.setup(24, GPIO.IN, pull_up_down=GPIO.PUD_UP)
GPIO.setup(25, GPIO.IN, pull_up_down=GPIO.PUD_UP)
GPIO.setup(27, GPIO.IN, pull_up_down=GPIO.PUD_UP)
GPIO.setup(18, GPIO.IN, pull_up_down=GPIO.PUD_UP)





def threaded_function(arg):
    for i in range(arg):
        print("running")
        sleep(1)


if __name__ == "__main__":
    thread = Thread(target = threaded_function, args = (10, ))
    thread.start()
    thread.join()
    print("thread finished...exiting")



while True:
    left_up_state = GPIO.input(22)
    left_down_state = GPIO.input(23)
    right_up_state = GPIO.input(24)
    right_down_state = GPIO.input(25)
    start_state = GPIO.input(27)
    reset_state = GPIO.input(18)
    if left_up_state == False:
        keyboard.press('w')
    else:
        keyboard.release('w')
    
    if left_down_state == False:
        keyboard.press('s')
    else:
        keyboard.release('s')
    
    if right_up_state == False:
        keyboard.press(Key.up)
    else:
        keyboard.release(Key.up)
    
    if right_down_state == False:
        keyboard.press(Key.down)
    else:
        keyboard.release(Key.down)
    
    if start_state == False:
        keyboard.press('g')
    else:
        keyboard.release('g')
    
    if reset_state == False:
        keyboard.press('r')
    else:
        keyboard.release('r')
