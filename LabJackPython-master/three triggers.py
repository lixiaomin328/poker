  #from __future__ import absolute_import, division #is this commented out? 
from psychopy import locale_setup, sound, gui, visual, core, data, event, logging, clock, hardware,monitors
from psychopy.constants import (NOT_STARTED, STARTED, PLAYING, PAUSED,
                                STOPPED, FINISHED, PRESSED, RELEASED, FOREVER)
import numpy as np  # whole numpy lib is available, prepend 'np.'
from numpy import (sin, cos, tan, log, log10, pi, average,
                   sqrt, std, deg2rad, rad2deg, linspace, asarray)
from numpy.random import random, randint, normal, shuffle
import pylink
from EyeLinkCoreGraphicsPsychoPy import EyeLinkCoreGraphicsPsychoPy
import earnings2
import os  # handy system and path functions
import sys  # to get file system encoding
import random
import pandas
from enum import Enum
useGUI = True #  use the Psychopy GUI module to collect subject information
dummyMode = True # Simulated connection to the tracker; press ESCAPE to skip calibration/validataion

#LABJACK
#note--need all the labjack files in the same dir
#ADD IMPORT LINE IF NEEDED
#os.chdir("/Users/virginiafedrigo/Desktop/LabJackPython-master")
import time
from psychopy.hardware.labjacks import u3
d = u3.U3() #d is the object labjack
#WORKING CODE set to FIO4 : for starting decisions (when P1, P2 decision periods start)
configDict = d.configIO()
configDict["FIOAnalog"]
d.configIO(FIOAnalog = 15)
d.getFeedback(u3.BitDirWrite(4,0)) #set low setup
#TEST CODE set to FIO5 : for decision made (ending of P1, P2 decision period)
configDict = d.configIO()
configDict["FIOAnalog"]
d.configIO(FIOAnalog = 15)
d.getFeedback(u3.BitDirWrite(5,0)) #set low setup
#TEST CODE set to FIO6 : for outcome revealed (any)
configDict = d.configIO()
configDict["FIOAnalog"]
d.configIO(FIOAnalog = 15)
d.getFeedback(u3.BitDirWrite(6,0)) #set low setup


# STEP I: get subject info
expInfo = {'SubjectNO':'00', 'SubjectInitials':'TEST'}

if useGUI:
    from psychopy import gui
    dlg = gui.DlgFromDict(dictionary=expInfo, title="GC Example", order=['SubjectNO', 'SubjectInitials'])
    if dlg.OK == False: core.quit()  # user pressed cancel
else:
    expInfo['SubjectNO'] = raw_input('Subject # (1-99): ')
    expInfo['SubjectInitials'] = raw_input('Subject Initials (e.g., WZ): ')

 #SETP II: established a link to the tracker

if not dummyMode: 
    tk = pylink.EyeLink('100.1.1.1')
else:
    tk = pylink.EyeLink(None)

#STEP III: Open an EDF data file EARLY
#Note that the file name cannot exceeds 8 characters
#please open eyelink data files early to record as much info as possible
dataFolder = os.getcwd() + '/edfData/'
if not os.path.exists(dataFolder): 
    os.makedirs(dataFolder)
dataFileName = expInfo['SubjectNO'] + '_' + expInfo['SubjectInitials'] + '.EDF'
tk.openDataFile(dataFileName)
# add personalized data file header (preamble text)
tk.sendCommand("add_file_preamble_text 'Psychopy GC demo'") 


# Ensure that relative paths start from the same directory as this script
_thisDir = os.path.dirname(os.path.abspath(__file__))
os.chdir(_thisDir)

# Store info about the experiment session
psychopyVersion = '3.0.3'
expName = 'poker_test'  # from the Builder filename that created this script
expInfo['date'] = data.getDateStr()  # add a simple timestamp
expInfo['expName'] = expName
expInfo['psychopyVersion'] = psychopyVersion

# Data file name stem = absolute path + name; later add .psyexp, .csv, .log, etc
filename = _thisDir + os.sep + 'data/%s_%s_%s' % (expInfo['SubjectNO'], expName, expInfo['date'])

# An ExperimentHandler isn't essential but helps with data saving
thisExp = data.ExperimentHandler(name=expName, version='',
    extraInfo=expInfo, runtimeInfo=None,
    originPath='/Users/lixiaomin/Documents/GitHub/poker/poker_test_lastrun.py',
    savePickle=True, saveWideText=True,
    dataFileName=filename)
# save a log file for detail verbose info
logFile = logging.LogFile(filename+'.log', level=logging.EXP)
logging.console.setLevel(logging.WARNING)  # this outputs to the screen, not a file

# STEP IV: Initialize custom graphics for camera setup & drift correction
#scnWidth, scnHeight = (2560, 1440)
scnWidth, scnHeight = (1280, 1024)
scnWidth1, scnHeight1 = (1280, 1024)
# for mon in monitors.getAllMonitors():
#     size1 = monitors.Monitor(mon).getSizePix())
##Window Set up
mon = monitors.Monitor('myMac15', width=53.0, distance=70.0)
mon.setSizePix((scnWidth, scnHeight))
mon1 = monitors.Monitor('testMonitor', width=53.0, distance=70.0)
mon1.setSizePix((scnWidth, scnHeight))
win = visual.Window((scnWidth, scnHeight), screen=0, fullscr=True, monitor=mon, color=[0,0,0], units='pix', allowStencil=True,autoLog=False)
win1 = visual.Window(  
    (scnWidth1, scnHeight1), screen=2, fullscr=False,
    allowGUI=False, allowStencil=True,
    monitor=mon1, color=[0,0,0], colorSpace='rgb',
    blendMode='avg', useFBO=True,
    units='pix')
endExpNow = False  # flag for 'escape' or other condition => quit the exp
# Start Code - component code to be run before the window creation

#eye tracker
genv = EyeLinkCoreGraphicsPsychoPy(tk, win)
pylink.openGraphicsEx(genv)
tk.setOfflineMode()

 # sampling rate, 250, 500, 1000, or 2000; this command won't work for EyeLInk II/I
tk.sendCommand('sample_rate 500')

 # inform the tracker the resolution of the subject display
 # [see Eyelink Installation Guide, Section 8.4: Customizing Your PHYSICAL.INI Settings ]
tk.sendCommand("screen_pixel_coords = 0 0 %d %d" % (scnWidth-1, scnHeight-1))

 # save display resolution in EDF data file for Data Viewer integration purposes
 # [see Data Viewer User Manual, Section 7: Protocol for EyeLink Data to Viewer Integration]
tk.sendMessage("DISPLAY_COORDS = 0 0 %d %d" % (scnWidth-1, scnHeight-1))

 # specify the calibration type, H3, HV3, HV5, HV13 (HV = horiztonal/vertical), 
tk.sendCommand("calibration_type = HV9") # tk.setCalibrationType('HV9') also works, see the Pylink manual

 # specify the proportion of subject display to calibrate/validate (OPTIONAL, useful for wide screen monitors)
 #tk.sendCommand("calibration_area_proportion 0.85 0.83")
 #tk.sendCommand("validation_area_proportion  0.85 0.83")

 # Using a button from the EyeLink Host PC gamepad to accept calibration/dirft check target (optional)
 # tk.sendCommand("button_function 5 'accept_target_fixation'")

 # the model of the tracker, 1-EyeLink I, 2-EyeLink II, 3-Newer models (100/1000Plus/DUO)
eyelinkVer = tk.getTrackerVersion()

 #turn off scenelink camera stuff (EyeLink II/I only)
if eyelinkVer == 2: 
    tk.sendCommand("scene_camera_gazemap = NO")

 # Set the tracker to parse Events using "GAZE" (or "HREF") data
tk.sendCommand("recording_parse_type = GAZE")

 # Online parser configuration: 0-> standard/coginitve, 1-> sensitive/psychophysiological
 # the Parser for EyeLink I is more conservative, see below
 # [see Eyelink User Manual, Section 4.3: EyeLink Parser Configuration]
if eyelinkVer>=2: 
    tk.sendCommand('select_parser_configuration 0')

 # get Host tracking software version
hostVer = 0
if eyelinkVer == 3:
    tvstr  = tk.getTrackerVersionString()
    vindex = tvstr.find("EYELINK CL")
    hostVer = int(float(tvstr[(vindex + len("EYELINK CL")):].strip()))

 # specify the EVENT and SAMPLE data that are stored in EDF or retrievable from the Link
 # See Section 4 Data Files of the EyeLink user manual
tk.sendCommand("file_event_filter = LEFT,RIGHT,FIXATION,SACCADE,BLINK,MESSAGE,BUTTON,INPUT")
tk.sendCommand("link_event_filter = LEFT,RIGHT,FIXATION,FIXUPDATE,SACCADE,BLINK,BUTTON,INPUT")
if hostVer>=4: 
    tk.sendCommand("file_sample_data  = LEFT,RIGHT,GAZE,AREA,GAZERES,STATUS,HTARGET,INPUT")
    tk.sendCommand("link_sample_data  = LEFT,RIGHT,GAZE,GAZERES,AREA,STATUS,HTARGET,INPUT")
else:          
    tk.sendCommand("file_sample_data  = LEFT,RIGHT,GAZE,AREA,GAZERES,STATUS,INPUT")
    tk.sendCommand("link_sample_data  = LEFT,RIGHT,GAZE,GAZERES,AREA,STATUS,INPUT")
 #gazeWindow = visual.Aperture(win, size=200)
 #gazeWindow.enabled=False
 # prepare a gaze-contingent mask
gazeMask = visual.GratingStim(win, tex='none', mask='circle', size=200, color=[1.0,1.0,1.0])
 #end eyetracking
 # store frame rate of monitor if we can measure it
expInfo['frameRate'] = win.getActualFrameRate()
if expInfo['frameRate'] != None:
    frameDur = 1.0 / round(expInfo['frameRate'])
else:
    frameDur = 1.0 / 60.0  # could not measure, so guess

tk.setOfflineMode()
pylink.pumpDelay(50)
tk.sendMessage('TRIALID')

 # record_status_message : show some info on the host PC

 # drift check
try:
    err = tk.doDriftCorrect(scnWidth/2, scnHeight/2,1,1)
except:
    tk.doTrackerSetup()
 # send the standard "TRIALID" message to mark the start of a trial
 # [see Data Viewer User Manual, Section 7: Protocol for EyeLink Data to Viewer Integration]
tk.sendMessage('TRIALID')

 # record_status_message : show some info on the host PC
 # send the standard "TRIALID" message to mark the start of a trial
 # [see Data Viewer User Manual, Section 7: Protocol for EyeLink Data to Viewer Integration]
tk.sendMessage('TRIALID')
error = tk.startRecording(1,1,1,1)
pylink.pumpDelay(100) # wait for 100 ms to make sure data of interest is recorded

 #determine which eye(s) are available
eyeTracked = tk.eyeAvailable() 
if eyeTracked==2: 
    eyeTracked = 1
#end of eyetracking block 1
#enable the gaze-contingent aperture in the 'window' condition


#Eyetracker 2
if not dummyMode: 
    tk2 = pylink.EyeLink('100.1.1.11')
else:
    tk2 = pylink.EyeLink(None)
dataFileName1 = expInfo['SubjectNO'] + '_'+'.EDF'
tk2.openDataFile(dataFileName1)
# add personalized data file header (preamble text)
tk2.sendCommand("add_file_preamble_text 'Psychopy GC demo'") 
genv1 = EyeLinkCoreGraphicsPsychoPy(tk2, win1)
pylink.openGraphicsEx(genv1)
tk2.setOfflineMode()

 # sampling rate, 250, 500, 1000, or 2000; this command won't work for EyeLInk II/I
tk2.sendCommand('sample_rate 500')

 # inform the tracker the resolution of the subject display
 # [see Eyelink Installation Guide, Section 8.4: Customizing Your PHYSICAL.INI Settings ]
tk2.sendCommand("screen_pixel_coords = 0 0 %d %d" % (scnWidth-1, scnHeight-1))

 # save display resolution in EDF data file for Data Viewer integration purposes
 # [see Data Viewer User Manual, Section 7: Protocol for EyeLink Data to Viewer Integration]
tk2.sendMessage("DISPLAY_COORDS = 0 0 %d %d" % (scnWidth-1, scnHeight-1))

 # specify the calibration type, H3, HV3, HV5, HV13 (HV = horiztonal/vertical), 
tk2.sendCommand("calibration_type = HV9") # tk.setCalibrationType('HV9') also works, see the Pylink manual

 # specify the proportion of subject display to calibrate/validate (OPTIONAL, useful for wide screen monitors)
 #tk.sendCommand("calibration_area_proportion 0.85 0.83")
 #tk.sendCommand("validation_area_proportion  0.85 0.83")

 # Using a button from the EyeLink Host PC gamepad to accept calibration/dirft check target (optional)
 # tk.sendCommand("button_function 5 'accept_target_fixation'")

 # the model of the tracker, 1-EyeLink I, 2-EyeLink II, 3-Newer models (100/1000Plus/DUO)
eyelinkVer = tk2.getTrackerVersion()

 #turn off scenelink camera stuff (EyeLink II/I only)
if eyelinkVer == 2: 
    tk2.sendCommand("scene_camera_gazemap = NO")

 # Set the tracker to parse Events using "GAZE" (or "HREF") data
tk2.sendCommand("recording_parse_type = GAZE")

 # Online parser configuration: 0-> standard/coginitve, 1-> sensitive/psychophysiological
 # the Parser for EyeLink I is more conservative, see below
 # [see Eyelink User Manual, Section 4.3: EyeLink Parser Configuration]
if eyelinkVer>=2: 
    tk2.sendCommand('select_parser_configuration 0')

 # get Host tracking software version
hostVer = 0
if eyelinkVer == 3:
    tvstr  = tk2.getTrackerVersionString()
    vindex = tvstr.find("EYELINK CL")
    hostVer = int(float(tvstr[(vindex + len("EYELINK CL")):].strip()))

 # specify the EVENT and SAMPLE data that are stored in EDF or retrievable from the Link
 # See Section 4 Data Files of the EyeLink user manual
tk2.sendCommand("file_event_filter = LEFT,RIGHT,FIXATION,SACCADE,BLINK,MESSAGE,BUTTON,INPUT")
tk2.sendCommand("link_event_filter = LEFT,RIGHT,FIXATION,FIXUPDATE,SACCADE,BLINK,BUTTON,INPUT")
if hostVer>=4: 
    tk2.sendCommand("file_sample_data  = LEFT,RIGHT,GAZE,AREA,GAZERES,STATUS,HTARGET,INPUT")
    tk2.sendCommand("link_sample_data  = LEFT,RIGHT,GAZE,GAZERES,AREA,STATUS,HTARGET,INPUT")
else:          
    tk2.sendCommand("file_sample_data  = LEFT,RIGHT,GAZE,AREA,GAZERES,STATUS,INPUT")
    tk2.sendCommand("link_sample_data  = LEFT,RIGHT,GAZE,GAZERES,AREA,STATUS,INPUT")
 #gazeWindow = visual.Aperture(win, size=200)
 #gazeWindow.enabled=False
 # prepare a gaze-contingent mask
gazeMask = visual.GratingStim(win1, tex='none', mask='circle', size=200, color=[1.0,1.0,1.0])
 #end eyetracking
 # store frame rate of monitor if we can measure it
expInfo['frameRate'] = win1.getActualFrameRate()
if expInfo['frameRate'] != None:
    frameDur = 1.0 / round(expInfo['frameRate'])
else:
    frameDur = 1.0 / 60.0  # could not measure, so guess

tk2.setOfflineMode()
pylink.pumpDelay(50)
tk2.sendMessage('TRIALID')

 # record_status_message : show some info on the host PC

 # drift check
try:
    err = tk2.doDriftCorrect(scnWidth1/2, scnHeight1/2,1,1)
except:
    tk2.doTrackerSetup()
 # send the standard "TRIALID" message to mark the start of a trial
 # [see Data Viewer User Manual, Section 7: Protocol for EyeLink Data to Viewer Integration]
tk2.sendMessage('TRIALID')

 # record_status_message : show some info on the host PC
 # send the standard "TRIALID" message to mark the start of a trial
 # [see Data Viewer User Manual, Section 7: Protocol for EyeLink Data to Viewer Integration]
tk2.sendMessage('TRIALID')
error2 = tk2.startRecording(1,1,1,1)
pylink.pumpDelay(100) # wait for 100 ms to make sure data of interest is recorded

 #determine which eye(s) are available
eyeTracked = tk2.eyeAvailable() 
if eyeTracked==2: 
    eyeTracked = 1
#end of eyetracking block 1
#enable the gaze-contingent aperture in the 'window' condition
# Initialize components for Routine "trial"
#messy set ups for game
deckRange = range(2,9)
cardImageDir = 'cards/'
TrialNum = 40 #CHANGE HERE
timeLimit = 10
rewardRevealTime = 4
sessionBreakN = 20
class GameStatus(Enum):
    GAME_NOT_STARTED = 0
    GAME_PLAYER_1_ROUND_STARTED = 1
    GAME_PLAYER_1_BET_RESULT = 2
    GAME_PLAYER_1_CHECK_RESULT = 3
    GAME_PLAYER_2_ROUND_STARTED = 4
    GAME_PLAYER_2_BET_RESULT = 5
    GAME_PLAYER_2_FOLD_RESULT = 6
    GAME_FINISHED = -1
trialClock = core.Clock()
handCapital = visual.TextStim(win=win, name='handCapital',
    text='Your card',
    font='Arial',
    pos=(-0.35*scnWidth,0.4*scnHeight), height=0.04*scnHeight, wrapWidth=None, ori=0, 
    color='white', colorSpace='rgb', opacity=1, 
    languageStyle='LTR',
    depth=0.0);
imageP1 = visual.ImageStim(
    win=win, name='image',
    image="sin", 
    ori=0, pos=(-0.351*scnWidth,0.27*scnHeight), size=(0.1*scnWidth, 0.17*scnHeight),
    color=[1,1,1], colorSpace='rgb', opacity=1,
    flipHoriz=False, flipVert=False,
    texRes=128, interpolate=True, depth=0.0)
hand2Capital = visual.TextStim(win=win1, name='hand2Capital',
    text='Your card',
    font='Arial',
    pos=(-0.35*scnWidth1,0.4*scnHeight1), height=0.04*scnHeight1, wrapWidth=None, ori=0, 
    color='white', colorSpace='rgb', opacity=1, 
    languageStyle='LTR',
    depth=-1.0);
potText1 = visual.TextStim(win=win, name='handCapital',
    text='Current Pot: \n 2',
    font='Arial',
    pos=(0.35*scnWidth,-0.25*scnHeight), height=0.04*scnHeight, wrapWidth=None, ori=0, 
    color='white', colorSpace='rgb', opacity=1, 
    languageStyle='LTR',
    depth=0.0);
potText2 = visual.TextStim(win=win1, name='handCapital',
    text='Current Pot: \n 2',
    font='Arial',
    pos=(0.35*scnWidth1,-0.25*scnHeight1), height=0.04*scnHeight, wrapWidth=None, ori=0, 
    color='white', colorSpace='rgb', opacity=1, 
    languageStyle='LTR',
    depth=0.0);
imageP2 = visual.ImageStim(
    win=win1, name='image1',
    image="sin", 
    ori=0, pos=(-0.35*scnWidth1,0.27*scnHeight1), size=(0.1*scnWidth1, 0.17*scnHeight1),
    color=[1,1,1], colorSpace='rgb', opacity=1,
    flipHoriz=False, flipVert=False,
    texRes=128, interpolate=True, depth=0.0)
                               
P1WaitingWords = visual.TextStim(win=win, name='P1WaitingWords',
    text='default text',
    font='Arial',
    pos=(0,0), height=0.035*scnHeight, wrapWidth=1000, ori=0, 
    color='Blue', colorSpace='rgb', opacity=1, 
    languageStyle='LTR',
    depth=-1.0);
                               
P2WaitingWords = visual.TextStim(win=win1, name='P2WaitingWords',
    text='default text',
    font='Arial',
    pos=(0,0 ), height=0.035*scnHeight1, wrapWidth=1000, ori=0, 
    color='Blue', colorSpace='rgb', opacity=1, 
    languageStyle='LTR',
    depth=-1.0);
                               
handOpponentCapital = visual.TextStim(win=win, name='handOpponentCapital',
    text='Your opponent card',
    font='Arial',
    pos=(0.35*scnWidth,0.4*scnHeight), height=0.04*scnHeight, wrapWidth=None, ori=0, 
    color='white', colorSpace='rgb', opacity=1, 
    languageStyle='LTR',
    depth=0.0);
hand2OpponentCapital = visual.TextStim(win=win1, name='hand2OpponentCapital',
    text='Your opponent card',
    font='Arial',
    pos=(0.35*scnWidth1,0.4*scnHeight1), height=0.04*scnHeight1, wrapWidth=None, ori=0, 
    color='white', colorSpace='rgb', opacity=1, 
    languageStyle='LTR',
    depth=-1.0);
imageOpp1 = visual.ImageStim(
    win=win, name='image',
    image=cardImageDir+"back.png", 
    ori=0, pos=(0.3*scnWidth,0.27*scnHeight), size=(0.1*scnWidth, 0.17*scnHeight),
    color=[1,1,1], colorSpace='rgb', opacity=1,
    flipHoriz=False, flipVert=False,
    texRes=128, interpolate=True, depth=0.0)

imageOpp2 = visual.ImageStim(
    win=win1, name='image',
    image=cardImageDir+"back.png", 
    ori=0, pos=(0.3*scnWidth1,0.27*scnHeight1), size=(0.1*scnWidth1, 0.17*scnHeight1),
    color=[1,1,1], colorSpace='rgb', opacity=1,
    flipHoriz=False, flipVert=False,
    texRes=128, interpolate=True, depth=0.0)
                               
decks = visual.TextStim(win=win, name='decks',
    text='Current decks\n2,3,4,5,6,7,8',
    font='Arial',
    pos=(0,-0.35*scnHeight), height=0.03*scnHeight, wrapWidth=None, ori=0, 
    color='white', colorSpace='rgb', opacity=1, 
    languageStyle='LTR',
    depth=-2.0);
decks2 = visual.TextStim(win=win1, name='decks2',
    text='Current decks\n2,3,4,5,6,7,8',
    font='Arial',
    pos=(0,-0.35*scnHeight1), height=0.03*scnHeight1, wrapWidth=None, ori=0, 
    color='white', colorSpace='rgb', opacity=1, 
    languageStyle='LTR',
    depth=-2.0); 
Reshuffling = visual.TextStim(win=win, name='handOpponentCapital',
    text=' Press (SPACE) to enter next trial',
    font='Arial',
    pos=(0,0), height=0.04*scnHeight, wrapWidth=None, ori=0, 
    color='white', colorSpace='rgb', opacity=1, 
    languageStyle='LTR',
    depth=0.0);
Reshuffling1 = visual.TextStim(win=win1, name='handOpponentCapital',
    text='Waiting for P1 to get prepared for the next trial',
    font='Arial',
    pos=(0,0), height=0.04*scnHeight, wrapWidth=None, ori=0, 
    color='white', colorSpace='rgb', opacity=1, 
    languageStyle='LTR',
    depth=0.0);
                       

# Create some handy timers
globalClock = core.Clock()  # to track the time since experiment started
routineTimer = core.CountdownTimer()  # to track time remaining of each (non-slip) routine 

# set up handler to look after randomisation of conditions etc
trials = data.TrialHandler(nReps=TrialNum, method='random', 
    extraInfo=expInfo, originPath=-1,
    trialList=[None],
    seed=None, name='trials')
thisExp.addLoop(trials)  # add the loop to the experiment
thisTrial = trials.trialList[0]  # so we can initialise stimuli with some values
# abbreviate parameter names if possible (e.g. rgb = thisTrial.rgb)
if thisTrial != None:
    for paramName in thisTrial:
        exec('{} = thisTrial[paramName]'.format(paramName))

for thisTrial in trials:
    currentLoop = trials
    # abbreviate parameter names if possible (e.g. rgb = thisTrial.rgb)
    if thisTrial != None:
        for paramName in thisTrial:
            exec('{} = thisTrial[paramName]'.format(paramName))
    if trials.thisN==0:
        P1WaitingWords.setText('You will have three practice trials,\nit will not count towards the payment')
        P2WaitingWords.setText('You will have three practice trials,\nit will not count towards the payment')
        P1WaitingWords.setAutoDraw(True)
        P2WaitingWords.setAutoDraw(True)
        win.flip()
        win1.flip()
        event.waitKeys(keyList = ["space",'n'])
        P1WaitingWords.setAutoDraw(False)
        P2WaitingWords.setAutoDraw(False)
    # ------Prepare to start Routine "trial"-------
    t = 0
    trialClock.reset()  # clock
    frameN = -1
    conitueRoutine = True
    cards = np.asarray(random.sample(deckRange, 2))
    p1card = str(cards[0])
    p2card = str(cards[1])

    
    # update component parameters for each repeat
    tk.sendMessage("record_status_message 'Card P1: %d'"% cards[0])
    tk2.sendMessage("record_status_message 'Card P2: %d'"% cards[1])
    imageP1.setImage(cardImageDir+p1card+'.png')
    imageP2.setImage(cardImageDir+p2card+'.png')
    
    
#    image.draw()
    P1WaitingWords.setText('Press (b) to bet\nPress (h) to check')
    P2WaitingWords.setText('Wait for player 1 making decision')
    potText1.setText('Current Pot: \n 2')
    potText2.setText('Current Pot: \n 2')
    player1ActionCheck = event.BuilderKeyResponse()
    player2ActionCheck = event.BuilderKeyResponse()
    gameStatus = GameStatus.GAME_NOT_STARTED
    # keep track of which components have finished
    trialComponents = [handCapital, hand2Capital, decks,decks2,P1WaitingWords,P2WaitingWords, 
                       handOpponentCapital,handOpponentCapital,player1ActionCheck, player2ActionCheck,
                       gameStatus,imageP1,imageP2,potText1,potText2]
    for thisComponent in trialComponents:
        if hasattr(thisComponent, 'status'):
            thisComponent.status = NOT_STARTED

    # -------Start Routine "trial"-------
    while gameStatus != GameStatus.GAME_FINISHED and conitueRoutine:
        # get current time
        t = trialClock.getTime()
        frameN = frameN + 1  # number of completed frames (so 0 is the first frame)
        # update/draw components on each frame

        # *handCapital* updates
        if gameStatus == GameStatus.GAME_NOT_STARTED:
            gameStatus = GameStatus.GAME_PLAYER_1_ROUND_STARTED
            Reshuffling.setAutoDraw(False)
            Reshuffling1.setAutoDraw(False)
            # keep track of start time/frame for later
            handCapital.tStart = t
            handCapital.frameNStart = frameN  # exact frame index
            handCapital.setAutoDraw(True)
            
            if t >= 0.0 and imageP1.status == NOT_STARTED:
                # keep track of start time/frame for later
                imageP1.tStart = t
                imageP1.frameNStart = frameN  # exact frame index
                imageP1.setAutoDraw(True)
            frameRemains = 0.0 + 1- win.monitorFramePeriod * 0.75  # most of one frame period left
            if imageP1.status == STARTED and t >= frameRemains:
                imageP1.setAutoDraw(False)
                
            if t >= 0.0 and imageP2.status == NOT_STARTED:
                # keep track of start time/frame for later
                imageP2.tStart = t
                imageP2.frameNStart = frameN  # exact frame index
                imageP2.setAutoDraw(True)
            frameRemains = 0.0 + 1- win.monitorFramePeriod * 0.75  # most of one frame period left
            if imageP2.status == STARTED and t >= frameRemains:
                imageP2.setAutoDraw(False)
            
            if t >= 0.0:
                # keep track of start time/frame for later
                imageOpp1.tStart = t
                imageOpp1.frameNStart = frameN  # exact frame index
                imageOpp1.setAutoDraw(True)
            frameRemains = 0.0 + 1- win.monitorFramePeriod * 0.75  # most of one frame period left
            if imageOpp1.status == STARTED and t >= frameRemains:
                imageOpp1.setAutoDraw(False)
                
            if t >= 0.0:
                # keep track of start time/frame for later
                imageOpp2.tStart = t
                imageOpp2.frameNStart = frameN  # exact frame index
                imageOpp2.setAutoDraw(True)
            frameRemain2 = 0.0 + 1- win.monitorFramePeriod * 0.75  # most of one frame period left
            if imageOpp2.status == STARTED and t >= frameRemains:
                imageOpp2.setAutoDraw(False)
        
            # keep track of start time/frame for later
            hand2Capital.tStart = t
            hand2Capital.frameNStart = frameN  # exact frame index
            hand2Capital.setAutoDraw(True)
            
            potText1.tStart = t
            potText1.frameNStart = frameN  # exact frame index
            potText1.setAutoDraw(True)
            
            potText2.tStart = t
            potText2.frameNStart = frameN  # exact frame index
            potText2.setAutoDraw(True)
        
            # keep track of start time/frame for later
            handOpponentCapital.tStart = t
            handOpponentCapital.frameNStart = frameN  # exact frame index
            handOpponentCapital.setAutoDraw(True)
            
            # keep track of start time/frame for later
            hand2OpponentCapital.tStart = t
            hand2OpponentCapital.frameNStart = frameN  # exact frame index
            hand2OpponentCapital.setAutoDraw(True)
            
            # keep track of start time/frame for later
            decks2.tStart = t
            decks2.frameNStart = frameN  # exact frame index
            decks2.setAutoDraw(True)
            
            # keep track of start time/frame for later
            decks.tStart = t
            decks.frameNStart = frameN  # exact frame index
            decks.setAutoDraw(True)
            
            # keep track of start time/frame for later
            P1WaitingWords.tStart = t
            P1WaitingWords.frameNStart = frameN  # exact frame index
            P1WaitingWords.setAutoDraw(True)
            
            # keep track of start time/frame for later
            P2WaitingWords.tStart = t
            P2WaitingWords.frameNStart = frameN  # exact frame index
            P2WaitingWords.setAutoDraw(True)
            
            # keep track of start time/frame for later
            decks2.tStart = t
            decks2.frameNStart = frameN  # exact frame index
            decks2.setAutoDraw(True)
            
            # keep track of start time/frame for later
            player1ActionCheck.tStart = t
            player1ActionCheck.frameNStart = frameN  # exact frame index
            player1ActionCheck.status = STARTED
            # keyboard checking is just starting
            win.callOnFlip(player1ActionCheck.clock.reset)  # t=0 on next screen flip
            win1.callOnFlip(player1ActionCheck.clock.reset)
            tk.sendMessage("P1 prechoose")
            
            #LABJACK : FIO4 FOR DECISION START
            d.getFeedback(u3.BitStateWrite(4,1)) #set high
            d.getFeedback(u3.BitStateWrite(4,0)) #set low


            
            event.clearEvents(eventType='keyboard')
        elif gameStatus == GameStatus.GAME_PLAYER_1_ROUND_STARTED:          
            if player1ActionCheck.status == STARTED:
                theseKeys = event.getKeys(keyList=['b', 'h'])
                # check for quit:
                if "escape" in theseKeys:
                    endExpNow = True                
                

                if len(theseKeys) > 0:  # at least one key was pressed
                    tk.sendMessage("P1 choose time")
                    
                    #LABJACK : FIO5 FOR DECISION MADE
                    d.getFeedback(u3.BitStateWrite(5,1)) #set high
                    d.getFeedback(u3.BitStateWrite(5,0)) #set low


                    
                    
                
                    if player1ActionCheck.keys == []:  # then this was the first keypress
                        player1ActionCheck.keys = theseKeys[0]  # just the first key pressed
                        player1ActionCheck.rt = player1ActionCheck.clock.getTime()
                        core.wait(np.random.normal(3,0.1))
                        if player1ActionCheck.keys == 'b':
                            gameStatus = GameStatus.GAME_PLAYER_1_BET_RESULT
                        elif player1ActionCheck.keys == 'h':
                            gameStatus = GameStatus.GAME_PLAYER_1_CHECK_RESULT
                elif player1ActionCheck.clock.getTime()>timeLimit:
                    gameStatus = GameStatus.GAME_FINISHED
                    P1WaitingWords.setText('Time out, you earn -2')
                    P2WaitingWords.setText('Player 1 time out, you earn +2')
                    win.flip()
                    win1.flip()
                    core.wait(rewardRevealTime)
        elif gameStatus == GameStatus.GAME_PLAYER_1_BET_RESULT:
            gameStatus = GameStatus.GAME_PLAYER_2_ROUND_STARTED
            potText1.setText('Current Pot: \n 2 + 2 = 4')
            potText2.setText('Current Pot: \n 2 + 2 = 4')
            P1WaitingWords.setText('Wait for player 2 making decision')
            P2WaitingWords.setText('Player one bets,\n press (c) to call and (f) to fold')
            player2ActionCheck.tStart = t
            player2ActionCheck.frameNStart = frameN
            player2ActionCheck.status = STARTED
            # keyboard checking is just starting
            win.callOnFlip(player2ActionCheck.clock.reset)  # t=0 on next screen flip
            win1.callOnFlip(player2ActionCheck.clock.reset)
            tk.sendMessage("P2 prechoose")
            tk2.sendMessage("P2 prechoose")
            
            #LABJACK : FIO4 FOR DECISION START
            d.getFeedback(u3.BitStateWrite(4,1)) #set high
            d.getFeedback(u3.BitStateWrite(4,0)) #set low


            
            event.clearEvents(eventType='keyboard')
            
            
        elif gameStatus == GameStatus.GAME_PLAYER_1_CHECK_RESULT:
            win.flip()
            win1.flip()
            P2WaitingWords.setText('Player 1 chose to check,\nyou do not need to make a decision')
            P1WaitingWords.setAutoDraw(False)
            win.flip()
            win1.flip()
            tk.sendMessage("P1 checked")
            
            
            
            
            
            core.wait(3)
            P1WaitingWords.setAutoDraw(True)
            if cards[0]>cards[1]:
                P2WaitingWords.setText('Your card is smaller.\nYou earn -1')
                P1WaitingWords.setText('Your card is larger\nYou earn +1')
            else:
                P1WaitingWords.setText('Your card is smaller.\nYou earn -1')
                P2WaitingWords.setText('Your card is larger\nYou earn +1')
            win.flip()
            win1.flip()
            tk.sendMessage("check result revealed")
            tk2.sendMessage("check result revealed")
            
            #LABJACK : FIO6 FOR OUTCOME SHOWN
            d.getFeedback(u3.BitStateWrite(6,1)) #set high
            d.getFeedback(u3.BitStateWrite(6,0)) #set low


            
            core.wait(rewardRevealTime)
            gameStatus = GameStatus.GAME_FINISHED
            # TODO(xiaomin): set up text
            
        elif gameStatus == GameStatus.GAME_PLAYER_2_ROUND_STARTED:
            if player2ActionCheck.status == STARTED:
                theseKeys = event.getKeys(keyList=['c', 'f'])
                # check for quit:
                if "escape" in theseKeys:
                    endExpNow = True
                
                if len(theseKeys) > 0:  # at least one key was pressed
                    tk.sendMessage("P2 choose timed")
                    tk2.sendMessage("P2 choose timed")
                    
                    #LABJACK : FIO5 FOR DECISION MADE
                    d.getFeedback(u3.BitStateWrite(5,1)) #set high
                    d.getFeedback(u3.BitStateWrite(5,0)) #set low



#                    core.wait(timeLimit - player2ActionCheck.clock.getTime())
                    if player2ActionCheck.keys == []:  # then this was the first keypress
                        player2ActionCheck.keys = theseKeys[0]  # just the first key pressed
                        player2ActionCheck.rt = player2ActionCheck.clock.getTime()
                        if player2ActionCheck.keys == 'c':
                            gameStatus = GameStatus.GAME_PLAYER_2_BET_RESULT
                        elif player2ActionCheck.keys == 'f':
                            gameStatus = GameStatus.GAME_PLAYER_2_FOLD_RESULT
                elif player2ActionCheck.clock.getTime()>timeLimit:
                    gameStatus = GameStatus.GAME_FINISHED
                    P2WaitingWords.setText('Time out, you earn -2')
                    P1WaitingWords.setText('Player 2 time out, you earn +2')
                    win.flip()
                    win1.flip()
                    core.wait(rewardRevealTime)
            
        elif gameStatus == GameStatus.GAME_PLAYER_2_BET_RESULT:
            potText1.setText('Current Pot: \n 4 + 2 =6')
            potText2.setText('Current Pot: \n 4 + 2 =6')
            if cards[0]>cards[1]:
                P2WaitingWords.setText('Your card is smaller\nYou earn -3')
                P1WaitingWords.setText('Your opponent chose to bet.\nYour card is larger, you earn +3')
            else:
                P1WaitingWords.setText('Your opponent chose to bet.\nYour card is smaller, you earn -3')
                P2WaitingWords.setText('Your card is larger\nYou earn +3')
            win.flip()
            win1.flip()
            tk.sendMessage("bet result revealed")
            
            #LABJACK : FIO6 FOR RESULT REVEALED
            d.getFeedback(u3.BitStateWrite(6,1)) #set high
            d.getFeedback(u3.BitStateWrite(6,0)) #set low


            
            core.wait(rewardRevealTime)
            gameStatus = GameStatus.GAME_FINISHED
            # TODO(xiaomin): set up text
        
        elif gameStatus == GameStatus.GAME_PLAYER_2_FOLD_RESULT:
            gameStatus = GameStatus.GAME_FINISHED
            win.flip()
            win1.flip()
            P1WaitingWords.setText('Your opponent chose to fold and you earn +1')
            P2WaitingWords.setText('Since you folded, you earn -1')
            win.flip()
            win1.flip()
            tk.sendMessage("fold result revealed")
            
            #LABJACK : FIO6 FOR RESULT REVEALED
            d.getFeedback(u3.BitStateWrite(6,1)) #set high
            d.getFeedback(u3.BitStateWrite(6,0)) #set low


            
            
            core.wait(rewardRevealTime)


        # check for quit (typically the Esc key)
        if event.getKeys(keyList=["escape"]):#endExpNow: #or 
            win.close()
            win1.close()
            core.quit()
        # check if all components have finished
        if gameStatus == GameStatus.GAME_FINISHED: 
            # a component has requested a forced-end of Routine
            imageP1.setAutoDraw(False)
            imageOpp1.setAutoDraw(False)
            imageP2.setAutoDraw(False)
            imageOpp2.setAutoDraw(False)
            handCapital.setAutoDraw(False)
            hand2Capital.setAutoDraw(False)
            handOpponentCapital.setAutoDraw(False)
            hand2OpponentCapital.setAutoDraw(False)
            P1WaitingWords.setAutoDraw(False)
            P2WaitingWords.setAutoDraw(False)
            decks.setAutoDraw(False)
            decks2.setAutoDraw(False)
            potText1.setAutoDraw(False)
            potText2.setAutoDraw(False)
            Reshuffling.setAutoDraw(True)
            Reshuffling1.setAutoDraw(True)
            if trials.thisN==2 or trials.thisN%sessionBreakN==0:
                if trials.thisN==2:
                    Reshuffling.setText('That is the end of practice trial.\n Press (SPACE) if you are ready')
                    Reshuffling1.setText('Waiting for P1 to get prepared for the next trial')
                elif trials.thisN%sessionBreakN==0: 
                    Reshuffling1.setText('Waiting for P1 to get prepared for the next trial')
                    Reshuffling.setText('Press (SPACE) to enter next trial')    
                win.flip()
                win1.flip()
                conitueRoutine = False
                event.waitKeys(keyList = ["space"])
                if trials.thisN==2:
                    Reshuffling.setText('Waiting for P2 to get prepared')
                    Reshuffling1.setText('That is the end of practice trial.\n Press (Enter) if you are ready')
                elif trials.thisN%sessionBreakN==0:   
                    Reshuffling.setText('Waiting for P2 to get prepared')
                    Reshuffling1.setText('P1 is prepared, press (RETURN) to next trial')
                win.flip()
                win1.flip() 
                event.waitKeys(keyList = ["return",'b'])
            Reshuffling.setText('Reshuffling in 2s...\nContributing 1 point to the pot. \n')
            Reshuffling1.setText('Reshuffling in 2s...\nContributing 1 point to the pot. \n')
            win.flip()
            win1.flip()
            core.wait(2)
            conitueRoutine = True
            break        
            #break
        win.flip()
        win1.flip()

    tk.sendMessage('TRIAL_RESULT')

    # -------Ending Routine "trial"-------
    for thisComponent in trialComponents:
        if hasattr(thisComponent, "setAutoDraw"):
            thisComponent.setAutoDraw(False)
    # check responses
        trials.addData('P1card',cards[0])
        trials.addData('P2card',cards[1])
    if player1ActionCheck.keys in ['', [], None]:  # No response was made
        player1ActionCheck.keys=None
    trials.addData('player1ActionCheck.keys',player1ActionCheck.keys)
    if player1ActionCheck.keys != None:  # we had a response
        trials.addData('player1ActionCheck.rt', player1ActionCheck.rt)
        
    if player2ActionCheck.keys in ['', [], None]:  # No response was made
        player2ActionCheck.keys=None
    trials.addData('player2ActionCheck.keys',player2ActionCheck.keys)
    if player2ActionCheck.keys != None:  # we had a response
        trials.addData('player2ActionCheck.rt', player2ActionCheck.rt)
        
    # the Routine "trial" was not non-slip safe, so reset the non-slip timer
    routineTimer.reset()
    thisExp.nextEntry()


#completed 5 repeats of 'trials'
pylink.pumpDelay(100)
tk.stopRecording() # stop recording
tk2.stopRecording()
 # close the EDF data file
tk.setOfflineMode()
tk.closeDataFile()
tk2.setOfflineMode()
tk2.closeDataFile()
pylink.pumpDelay(50)

 # Get the EDF data and say goodbye
#tk.receiveDataFile(dataFileName, dataFolder + dataFileName)
tk2.receiveDataFile(dataFileName1, dataFolder + dataFileName1)
 #close the link to the tracker

tk2.close()
if not dummyMode: 
    tk3 = pylink.EyeLink('100.1.1.1')
else:
    tk3 = pylink.EyeLink(None)
tk3.receiveDataFile(dataFileName, dataFolder + dataFileName)
tk3.close()
 # close the graphics
pylink.closeGraphics()
# these shouldn't be strictly necessary (should auto-save)
thisExp.saveAsWideText(filename+'.csv')
thisExp.saveAsPickle(filename)
path = 'data/'
payment = earnings2.paymentOutput(path,filename+'.csv')
Reshuffling.setText('This is the end. Thank you. You earned ' +str(payment[0])+' points in total')
Reshuffling1.setText('This is the end. Thank you. You earned ' +str(payment[1])+' points in total')
win.flip()
win1.flip()
event.waitKeys(keyList = ["space"])
logging.flush()
# make sure everything is closed down
thisExp.abort()  # or data files will save again on exit

#LABJACK close
d.close()

win.close()
win1.close()
core.quit()
