#!/usr/bin/env python
# -*- coding: utf-8 -*-

"""
Functions to execute triggers using Measurement Computing PCI-DIO24 card.
This code uses cbw32.dll library which must be placed in the same directory.

Before using triggers, you need to configure board: configure().
You can send trigger using trigger(value,port,duration) function.

--- TECHNICAL INFO ---

Our cable connects:
FIRSTPORTC -> triggers 1-8 on BioSemi device
FIRSTPORTB -> triggers 9-16 on BioSemi device
Consult "DIO-BioSemi cable.pdf" for detailed specification of our connections between PCI-DIO card and BioSemi receiver.

Trigger 0 is used to clear previous trigger, so there is no possibility to
use trigger 0 as meaningful.

In our setup (NeuroLab-UJ), ports B0 and B1 are down, so we can set:
triggers 1-255 on FIRSTPORTC
triggers [4,8,12,...,252] on FIRSTPORTB.

v.20141214 Krzysztof Kutt krzysztof.kutt@gmail.com
"""

from ctypes import *
from time import sleep
import threading

PORT_1_8 = 1
PORT_9_16 = 2

#trigger duration (time before sending signal 0)
DURATION = 0.05

def configure():
  """Configures card 0 to use FIRSTPORTB and FIRSTPORTC as inputs.
  Returns 0 if everything is OK"""

  #cbDConfigPort(boardNumber, portNumber, mode):
  #  boardNumber -> always 0 (we have only one PCI-DIO24 card)
  #  portNumber -> 11 for FIRSTPORTB, 12 for FIRSTPORTC (lower bits), 13 for FIRSTPORTC (upper bits)
  #  mode -> 1 for input
  res1 = windll.cbw32.cbDConfigPort(0, 11, 1)
  res2 = windll.cbw32.cbDConfigPort(0, 12, 1)
  res3 = windll.cbw32.cbDConfigPort(0, 13, 1)
  return res1+res2+res3
  

def trigger_worker(value, port):
  """Sends trigger. This function is started by trigger()"""

  #send trigger:
  res = 0
  if port==PORT_9_16 :
    res = windll.cbw32.cbDOut(0, 11, value)
  else:
    val1 = value%16
    val2 = value//16
    res = windll.cbw32.cbDOut(0, 12, val1)
    res += windll.cbw32.cbDOut(0, 13, val2)

  sleep(DURATION)

  #clear trigger
  if port==PORT_9_16 :
    res += windll.cbw32.cbDOut(0, 11, 0)
  else:
    res += windll.cbw32.cbDOut(0, 12, 0)
    res += windll.cbw32.cbDOut(0, 13, 0)

  return res


def trigger(value, port=PORT_1_8):
  """Sends a trigger. Parameters:
  value: 1-255 for PORT_1_8; [4,8,12,...,252] for PORT_9_16
  port: PORT_1_8 or PORT_9_16 (as seen in BioSemi)."""

  #check input:
  error = 0
  if value<=0 or value > 255 :
    error = 1001
  if not( port==PORT_1_8 or port==PORT_9_16 ) :
    error = 1002
  if port==PORT_9_16 and value%4 != 0 :
    error = 1003
  if error != 0 :
    return error

  t = threading.Thread(target=trigger_worker, args=(value, port,))
  t.start()

