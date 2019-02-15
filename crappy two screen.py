from __future__ import absolute_import, division
from psychopy import locale_setup, sound, gui, visual, core, data, event, logging, clock, hardware
from psychopy.constants import (NOT_STARTED, STARTED, PLAYING, PAUSED,
                                STOPPED, FINISHED, PRESSED, RELEASED, FOREVER)
import numpy as np  # whole numpy lib is available, prepend 'np.'
from numpy import (sin, cos, tan, log, log10, pi, average,
                   sqrt, std, deg2rad, rad2deg, linspace, asarray)
from numpy.random import random, randint, normal, shuffle
import os  # handy system and path functions
import sys  # to get file system encoding
import random
deckRange = range(2,9)
# Ensure that relative paths start from the same directory as this script
_thisDir = os.path.dirname(os.path.abspath(__file__))
os.chdir(_thisDir)

# Store info about the experiment session
psychopyVersion = '3.0.3'
expName = 'poker_test'  # from the Builder filename that created this script
expInfo = {'participant': '', 'session': '001'}
dlg = gui.DlgFromDict(dictionary=expInfo, title=expName)
if dlg.OK == False:
    core.quit()  # user pressed cancel
expInfo['date'] = data.getDateStr()  # add a simple timestamp
expInfo['expName'] = expName
expInfo['psychopyVersion'] = psychopyVersion

# Data file name stem = absolute path + name; later add .psyexp, .csv, .log, etc
filename = _thisDir + os.sep + u'data/%s_%s_%s' % (expInfo['participant'], expName, expInfo['date'])

# An ExperimentHandler isn't essential but helps with data saving
thisExp = data.ExperimentHandler(name=expName, version='',
    extraInfo=expInfo, runtimeInfo=None,
    originPath='/Users/lixiaomin/Documents/GitHub/poker/poker_test_lastrun.py',
    savePickle=True, saveWideText=True,
    dataFileName=filename)
# save a log file for detail verbose info
logFile = logging.LogFile(filename+'.log', level=logging.EXP)
logging.console.setLevel(logging.WARNING)  # this outputs to the screen, not a file

endExpNow = False  # flag for 'escape' or other condition => quit the exp

# Start Code - component code to be run before the window creation

# Setup the Window
win1 = visual.Window(
    size=[1200, 800], fullscr=False, screen=1,
    allowGUI=False, allowStencil=False,
    monitor='testMonitor', color=[0,0,0], colorSpace='rgb',
    blendMode='avg', useFBO=True,
    units='norm')
win = visual.Window(
    size=[1200, 800], fullscr=False, screen=0,
    allowGUI=False, allowStencil=False,
    monitor='testMonitor', color=[0,0,0], colorSpace='rgb',
    blendMode='avg', useFBO=True,
    units='norm')
# store frame rate of monitor if we can measure it
expInfo['frameRate'] = win.getActualFrameRate()
if expInfo['frameRate'] != None:
    frameDur = 1.0 / round(expInfo['frameRate'])
else:
    frameDur = 1.0 / 60.0  # could not measure, so guess

# Initialize components for Routine "trial"
trialClock = core.Clock()
handCapital = visual.TextStim(win=win, name='handCapital',
    text='default text',
    font='Arial',
    pos=(-0.9,0.9), height=0.06, wrapWidth=None, ori=0, 
    color='white', colorSpace='rgb', opacity=1, 
    languageStyle='LTR',
    depth=0.0);
hand2Capital = visual.TextStim(win=win1, name='hand2Capital',
    text='default text',
    font='Arial',
    pos=(-0.5,0.8), height=0.1, wrapWidth=None, ori=0, 
    color='white', colorSpace='rgb', opacity=1, 
    languageStyle='LTR',
    depth=-1.0);
                               
handOpponentCapital = visual.TextStim(win=win, name='handOpponentCapital',
    text='Your opponent card: \n X',
    font='Arial',
    pos=(-0.2,0.9), height=0.06, wrapWidth=None, ori=0, 
    color='white', colorSpace='rgb', opacity=1, 
    languageStyle='LTR',
    depth=0.0);
hand2OpponentCapital = visual.TextStim(win=win1, name='hand2OpponentCapital',
    text='Your opponent card: \n X',
    font='Arial',
    pos=(0.5,0.8), height=0.1, wrapWidth=None, ori=0, 
    color='white', colorSpace='rgb', opacity=1, 
    languageStyle='LTR',
    depth=-1.0);
                               
decks = visual.TextStim(win=win, name='decks',
    text='Current decks\n2,3,4,5,6,7,8',
    font='Arial',
    pos=(-0.5,0.3), height=0.05, wrapWidth=None, ori=0, 
    color='white', colorSpace='rgb', opacity=1, 
    languageStyle='LTR',
    depth=-2.0);
decks2 = visual.TextStim(win=win1, name='decks2',
    text='Current decks\n2,3,4,5,6,7,8',
    font='Arial',
    pos=(0,-0.3), height=0.1, wrapWidth=None, ori=0, 
    color='white', colorSpace='rgb', opacity=1, 
    languageStyle='LTR',
    depth=-2.0);                        
                       

# Create some handy timers
globalClock = core.Clock()  # to track the time since experiment started
routineTimer = core.CountdownTimer()  # to track time remaining of each (non-slip) routine 

# set up handler to look after randomisation of conditions etc
trials = data.TrialHandler(nReps=5, method='random', 
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
    
    # ------Prepare to start Routine "trial"-------
    t = 0
    trialClock.reset()  # clock
    frameN = -1
    continueRoutine = True
    cards = np.asarray(random.sample(deckRange, 2))
    p1card = str(cards[0])
    p2card = str(cards[1])
    # update component parameters for each repeat
    handCapital.setText('you hand\n    '+p1card)
    hand2Capital.setText('your hand\n    '+p2card)
    betCheck = event.BuilderKeyResponse()
    # keep track of which components have finished
    trialComponents = [handCapital, hand2Capital, decks,decks2, handOpponentCapital,handOpponentCapital,betCheck]
    for thisComponent in trialComponents:
        if hasattr(thisComponent, 'status'):
            thisComponent.status = NOT_STARTED
    
    # -------Start Routine "trial"-------
    while continueRoutine:
        # get current time
        t = trialClock.getTime()
        frameN = frameN + 1  # number of completed frames (so 0 is the first frame)
        # update/draw components on each frame
        
        # *handCapital* updates
        if t >= 0.0 and handCapital.status == NOT_STARTED:
            # keep track of start time/frame for later
            handCapital.tStart = t
            handCapital.frameNStart = frameN  # exact frame index
            handCapital.setAutoDraw(True)
        
        # *hand2Capital* updates
        if t >= 0.0 and hand2Capital.status == NOT_STARTED:
            # keep track of start time/frame for later
            hand2Capital.tStart = t
            hand2Capital.frameNStart = frameN  # exact frame index
            hand2Capital.setAutoDraw(True)
        
        # *handOpponentCapital* updates
        if t >= 0.0 and handOpponentCapital.status == NOT_STARTED:
            # keep track of start time/frame for later
            handOpponentCapital.tStart = t
            handOpponentCapital.frameNStart = frameN  # exact frame index
            handOpponentCapital.setAutoDraw(True)
            
         # *hand2OpponentCapital* updates
        if t >= 0.0 and hand2OpponentCapital.status == NOT_STARTED:
            # keep track of start time/frame for later
            hand2OpponentCapital.tStart = t
            hand2OpponentCapital.frameNStart = frameN  # exact frame index
            hand2OpponentCapital.setAutoDraw(True)
        # *decks2* updates
        if t >= 0.0 and decks2.status == NOT_STARTED:
            # keep track of start time/frame for later
            decks2.tStart = t
            decks2.frameNStart = frameN  # exact frame index
            decks2.setAutoDraw(True)
        # *decks* updates
        if t >= 0.0 and decks.status == NOT_STARTED:
            # keep track of start time/frame for later
            decks.tStart = t
            decks.frameNStart = frameN  # exact frame index
            decks.setAutoDraw(True)
        # *decks2* updates
        if t >= 0.0 and decks2.status == NOT_STARTED:
            # keep track of start time/frame for later
            decks2.tStart = t
            decks2.frameNStart = frameN  # exact frame index
            decks2.setAutoDraw(True)
        
        # *betCheck* updates
        if t >= 0.0 and betCheck.status == NOT_STARTED:
            # keep track of start time/frame for later
            betCheck.tStart = t
            betCheck.frameNStart = frameN  # exact frame index
            betCheck.status = STARTED
            # keyboard checking is just starting
            win.callOnFlip(betCheck.clock.reset)  # t=0 on next screen flip
            win1.callOnFlip(betCheck.clock.reset)
            event.clearEvents(eventType='keyboard')
        if betCheck.status == STARTED:
            theseKeys = event.getKeys(keyList=['b', 'f', 'space'])
            
            # check for quit:
            if "escape" in theseKeys:
                endExpNow = True
            if len(theseKeys) > 0:  # at least one key was pressed
                if betCheck.keys == []:  # then this was the first keypress
                    betCheck.keys = theseKeys[0]  # just the first key pressed
                    betCheck.rt = betCheck.clock.getTime()
                    # a response ends the routine
                    continueRoutine = False
        
        # check for quit (typically the Esc key)
        if endExpNow or event.getKeys(keyList=["escape"]):
            core.quit()
        
        # check if all components have finished
        if not continueRoutine:  # a component has requested a forced-end of Routine
            break
        continueRoutine = False  # will revert to True if at least one component still running
        for thisComponent in trialComponents:
            if hasattr(thisComponent, "status") and thisComponent.status != FINISHED:
                continueRoutine = True
                break  # at least one component has not yet finished
        
        # refresh the screen
        if continueRoutine:  # don't flip if this routine is over or we'll get a blank screen
            win.flip()
            win1.flip()
    
    # -------Ending Routine "trial"-------
    for thisComponent in trialComponents:
        if hasattr(thisComponent, "setAutoDraw"):
            thisComponent.setAutoDraw(False)
    # check responses
    if betCheck.keys in ['', [], None]:  # No response was made
        betCheck.keys=None
    trials.addData('betCheck.keys',betCheck.keys)
    if betCheck.keys != None:  # we had a response
        trials.addData('betCheck.rt', betCheck.rt)
    # the Routine "trial" was not non-slip safe, so reset the non-slip timer
    routineTimer.reset()
    thisExp.nextEntry()
    
# completed 5 repeats of 'trials'

# these shouldn't be strictly necessary (should auto-save)
thisExp.saveAsWideText(filename+'.csv')
thisExp.saveAsPickle(filename)
logging.flush()
# make sure everything is closed down
thisExp.abort()  # or data files will save again on exit
win.close()
win1.close()
core.quit()