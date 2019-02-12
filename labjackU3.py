#!/usr/bin/env python
# -*- coding: utf-8 -*-

"""
Functions to execute triggers using LabJack U3 card.

Before using triggers, you need to configure board: configure().
You can send trigger using trigger(value,duration) function.

--- TECHNICAL INFO ---

Our cable connects:
FIO0-7 -> triggers 1-8 on BioSemi device

Trigger 0 is used to clear previous trigger, so there is no possibility to
use trigger 0 as meaningful.

version 20160212
(C) 2016 Krzysztof Kutt krzysztof.kutt@gmail.com
"""

from labjack import u3
from labjack.LabJackPython import LabJackException
from time import sleep
import threading

#trigger duration (time before sending signal 0)
DURATION = 0.05

#u3card is setted during calibration (if you use trigger without calibration there will be exception!)
u3card = None


def configure():
    """Configures LabJack U3 to use FIO ports as Digital Output.
       Sets signal 0 on card.
       Returns 0 if everything is OK"""
    
    global u3card
    u3card = u3.U3()
    u3card.configU3(FIOAnalog = 0, FIODirection = 255, FIOState = 0)
    u3card.configIO()
    u3card.getFeedback( u3.PortStateWrite(State = [0, 0x00, 0x00], WriteMask = [0xff, 0x00, 0x00] ) )
    return 0
  

def clear_trigger_worker(value):
    """Clears trigger. This function is started by trigger()"""
  
    global u3card
    sleep(DURATION)
    u3card.getFeedback( u3.PortStateWrite(State = [0, 0x00, 0x00], WriteMask = [0xff, 0x00, 0x00] ) )



def trigger(value):
    """Sends a trigger. Parameters:
       value: 1-255"""

    global u3card
    value = int(value)
  
    #check input:
    error = 0
    if value<=0 or value > 255 :
        error = 1001
    if error != 0 :
        return error

    #send trigger:
    '''PortStateWrite sets three bytes: FIO, EIO, CIO -- we only use the first one and ignore EIO and CIO'''
    try:
        u3card.getFeedback( u3.PortStateWrite(State = [value, 0x00, 0x00], WriteMask = [0xff, 0x00, 0x00] ) )
    except LabJackException as _:
        print "LABJACK ERROR. Trigger " + str(value) + " was not send!"

    t = threading.Thread(target=clear_trigger_worker, args=(value,))
    t.start()

