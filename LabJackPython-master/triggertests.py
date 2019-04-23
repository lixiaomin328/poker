import time
import os
os.chdir("/Users/virginiafedrigo/poker/LabJackPython-master")
from psychopy.hardware.labjacks import u3


d = u3.U3() #d is the object labjack

#byte=0


###WORKING CODE set to FIO4

configDict = d.configIO()
configDict["FIOAnalog"]
d.configIO(FIOAnalog = 15)
d.getFeedback(u3.BitDirWrite(4,0)) #set low setup
#the following after every event
for i in range(1,10,1):
    d.getFeedback(u3.BitStateWrite(4,0)) #set low 
    time.sleep(5)
    d.getFeedback(u3.BitStateWrite(4,1)) #set high
    time.sleep(5)
end


#d.setData(byte, endian='big', address=6700) #6008

#for loop_byte in range(1,3):
#    time.sleep(.1) # wait between triggers
#    d.setData(loop_byte)    # send trigger
#    print(loop_byte) # print to output
#
#close labjack
#d.close()

