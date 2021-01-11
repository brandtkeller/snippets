# !/bin/python

## Generic Python Script for running an infinite loop that waits for a button push action to execute a script.
## Requires absolute path to the script that it will execute.

import RPi.GPIO as GPIO

import time
import sys
import os

# Check for 2 arguments
if len(sys.argv) != 2:
    print 'Usage:   ./runscript.py /path/to/script.sh'

# Set the pins

GPIO.setmode(GPIO.BCM)

GPIO.setup(21, GPIO.IN, pull_up_down=GPIO.PUD_UP)


# Define a function for restarting
def RunScript(channel):

    print("Running Script: ", sys.argv[1])
    time.sleep(5)
    os.system(sys.argv[1])

# Execute 

GPIO.add_event_detect(21, GPIO.FALLING, callback=RunScript, bouncetime=2000)


# Loop and wait for detection
while 1:

    time.sleep(1)