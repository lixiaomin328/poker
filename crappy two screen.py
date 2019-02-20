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
from enum import Enum

class GameStatus(Enum):
	GAME_NOT_STARTED = 0
	GAME_PLAYER_1_ROUND_STARTED = 1
	GAME_PLAYER_1_BET_RESULT = 2
	GAME_PLAYER_1_CHECK_RESULT = 3
	GAME_PLAYER_2_ROUND_STARTED = 4
	GAME_PLAYER_2_BET_RESULT = 5
	GAME_PLAYER_2_FOLD_RESULT = 6
	GAME_FINISHED = -1

#messy set ups
deckRange = range(2,9)
cardImageDir = 'cards/'
TrialNum = 5
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
    size=[2024, 1468], pos =(0,0),fullscr=False, screen=1,
    allowGUI=False, allowStencil=False,
    monitor='testMonitor', color=[0,0,0], colorSpace='rgb',
    blendMode='avg', useFBO=True,
    units='norm')
win = visual.Window(
    size=[1800, 1000],pos = (0,0), fullscr=True, screen=0,
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
    text='Your card',
    font='Arial',
    pos=(-0.7,0.8), height=0.06, wrapWidth=None, ori=0, 
    color='white', colorSpace='rgb', opacity=1, 
    languageStyle='LTR',
    depth=0.0);
imageP1 = visual.ImageStim(
    win=win, name='image',
    image="sin", 
    ori=0, pos=(-0.7,0.55), size=(0.2, 0.35),
    color=[1,1,1], colorSpace='rgb', opacity=1,
    flipHoriz=False, flipVert=False,
    texRes=128, interpolate=True, depth=0.0)
hand2Capital = visual.TextStim(win=win1, name='hand2Capital',
    text='Your card',
    font='Arial',
    pos=(-0.5,0.8), height=0.1, wrapWidth=None, ori=0, 
    color='white', colorSpace='rgb', opacity=1, 
    languageStyle='LTR',
    depth=-1.0);
imageP2 = visual.ImageStim(
    win=win1, name='image1',
    image="sin", 
    ori=0, pos=(-0.5,0.55), size=(0.2, 0.35),
    color=[1,1,1], colorSpace='rgb', opacity=1,
    flipHoriz=False, flipVert=False,
    texRes=128, interpolate=True, depth=0.0)
                               
P1WaitingWords = visual.TextStim(win=win, name='P1WaitingWords',
    text='default text',
    font='Arial',
    pos=(0,0.2), height=0.1, wrapWidth=None, ori=0, 
    color='Blue', colorSpace='rgb', opacity=1, 
    languageStyle='LTR',
    depth=-1.0);
                               
P2WaitingWords = visual.TextStim(win=win1, name='P2WaitingWords',
    text='default text',
    font='Arial',
    pos=(0,0), height=0.1, wrapWidth=None, ori=0, 
    color='Blue', colorSpace='rgb', opacity=1, 
    languageStyle='LTR',
    depth=-1.0);
                               
handOpponentCapital = visual.TextStim(win=win, name='handOpponentCapital',
    text='Your opponent card',
    font='Arial',
    pos=(0.7,0.8), height=0.06, wrapWidth=None, ori=0, 
    color='white', colorSpace='rgb', opacity=1, 
    languageStyle='LTR',
    depth=0.0);
hand2OpponentCapital = visual.TextStim(win=win1, name='hand2OpponentCapital',
    text='Your opponent card',
    font='Arial',
    pos=(0.5,0.8), height=0.1, wrapWidth=None, ori=0, 
    color='white', colorSpace='rgb', opacity=1, 
    languageStyle='LTR',
    depth=-1.0);
imageOpp1 = visual.ImageStim(
    win=win, name='image',
    image=cardImageDir+"back.png", 
    ori=0, pos=(0.7,0.55), size=(0.2, 0.35),
    color=[1,1,1], colorSpace='rgb', opacity=1,
    flipHoriz=False, flipVert=False,
    texRes=128, interpolate=True, depth=0.0)

imageOpp2 = visual.ImageStim(
    win=win1, name='image',
    image=cardImageDir+"back.png", 
    ori=0, pos=(0.5,0.55), size=(0.2, 0.35),
    color=[1,1,1], colorSpace='rgb', opacity=1,
    flipHoriz=False, flipVert=False,
    texRes=128, interpolate=True, depth=0.0)
                               
decks = visual.TextStim(win=win, name='decks',
    text='Current decks\n2,3,4,5,6,7,8',
    font='Arial',
    pos=(0,-0.7), height=0.05, wrapWidth=None, ori=0, 
    color='white', colorSpace='rgb', opacity=1, 
    languageStyle='LTR',
    depth=-2.0);
decks2 = visual.TextStim(win=win1, name='decks2',
    text='Current decks\n2,3,4,5,6,7,8',
    font='Arial',
    pos=(0,-0.7), height=0.1, wrapWidth=None, ori=0, 
    color='white', colorSpace='rgb', opacity=1, 
    languageStyle='LTR',
    depth=-2.0);                        
                       

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
    
    # ------Prepare to start Routine "trial"-------
    t = 0
    trialClock.reset()  # clock
    frameN = -1
    cards = np.asarray(random.sample(deckRange, 2))
    p1card = str(cards[0])
    p2card = str(cards[1])
    # update component parameters for each repeat
    imageP1.setImage(cardImageDir+p1card+'.png')
    imageP2.setImage(cardImageDir+p2card+'.png')
#    image.draw()
    P1WaitingWords.setText('Please choose to bet or check now')
    P2WaitingWords.setText('Please wait for player 1 making his decision')
    player1ActionCheck = event.BuilderKeyResponse()
    player2ActionCheck = event.BuilderKeyResponse()
    gameStatus = GameStatus.GAME_NOT_STARTED
    # keep track of which components have finished
    trialComponents = [handCapital, hand2Capital, decks,decks2,P1WaitingWords,P2WaitingWords, 
                       handOpponentCapital,handOpponentCapital,player1ActionCheck, player2ActionCheck,
                       gameStatus,imageP1,imageP2]
    for thisComponent in trialComponents:
        if hasattr(thisComponent, 'status'):
            thisComponent.status = NOT_STARTED
        
    # -------Start Routine "trial"-------
    while gameStatus != GameStatus.GAME_FINISHED:
        # get current time
        t = trialClock.getTime()
        frameN = frameN + 1  # number of completed frames (so 0 is the first frame)
        # update/draw components on each frame
        
        # *handCapital* updates
        if gameStatus == GameStatus.GAME_NOT_STARTED:
            gameStatus = GameStatus.GAME_PLAYER_1_ROUND_STARTED
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
            
            if t >= 0.0 and imageOpp1.status == NOT_STARTED:
                # keep track of start time/frame for later
                imageOpp1.tStart = t
                imageOpp1.frameNStart = frameN  # exact frame index
                imageOpp1.setAutoDraw(True)
            frameRemains = 0.0 + 1- win.monitorFramePeriod * 0.75  # most of one frame period left
            if imageOpp1.status == STARTED and t >= frameRemains:
                imageOpp1.setAutoDraw(False)
                
            if t >= 0.0 and imageOpp2.status == NOT_STARTED:
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
            event.clearEvents(eventType='keyboard')
        elif gameStatus == GameStatus.GAME_PLAYER_1_ROUND_STARTED:            
            if player1ActionCheck.status == STARTED:
                theseKeys = event.getKeys(keyList=['b', 'c'])
                # check for quit:
                if "escape" in theseKeys:
                    endExpNow = True
                if len(theseKeys) > 0:  # at least one key was pressed
                    if player1ActionCheck.keys == []:  # then this was the first keypress
                        player1ActionCheck.keys = theseKeys[0]  # just the first key pressed
                        player1ActionCheck.rt = player1ActionCheck.clock.getTime()
                        if player1ActionCheck.keys == 'b':
                            gameStatus = GameStatus.GAME_PLAYER_1_BET_RESULT
                        elif player1ActionCheck.keys == 'c':
                            gameStatus = GameStatus.GAME_PLAYER_1_CHECK_RESULT
        elif gameStatus == GameStatus.GAME_PLAYER_1_BET_RESULT:
            gameStatus = GameStatus.GAME_PLAYER_2_ROUND_STARTED
            P1WaitingWords.setText('Please wait for player 2 making his decision')
            P2WaitingWords.setText('Player one choose to bet,\n now it is your turn')
            player2ActionCheck.tStart = t
            player2ActionCheck.frameNStart = frameN
            player2ActionCheck.status = STARTED
            # keyboard checking is just starting
            win.callOnFlip(player2ActionCheck.clock.reset)  # t=0 on next screen flip
            win1.callOnFlip(player2ActionCheck.clock.reset)
            event.clearEvents(eventType='keyboard')
            
        elif gameStatus == GameStatus.GAME_PLAYER_1_CHECK_RESULT:
            P2WaitingWords.setText('Player one choose to check,\n you do not need to \n make a decision yourself in \n the current round')
            gameStatus = GameStatus.GAME_FINISHED
            # TODO(xiaomin): set up text
            
        elif gameStatus == GameStatus.GAME_PLAYER_2_ROUND_STARTED:
            if player2ActionCheck.status == STARTED:
                theseKeys = event.getKeys(keyList=['b', 'f'])
                # check for quit:
                if "escape" in theseKeys:
                    endExpNow = True
                if len(theseKeys) > 0:  # at least one key was pressed
                    if player2ActionCheck.keys == []:  # then this was the first keypress
                        player2ActionCheck.keys = theseKeys[0]  # just the first key pressed
                        player2ActionCheck.rt = player2ActionCheck.clock.getTime()
                        if player2ActionCheck.keys == 'b':
                            gameStatus = GameStatus.GAME_PLAYER_2_BET_RESULT
                        elif player2ActionCheck.keys == 'f':
                            gameStatus = GameStatus.GAME_PLAYER_2_FOLD_RESULT
            
        elif gameStatus == GameStatus.GAME_PLAYER_2_BET_RESULT:
            gameStatus = GameStatus.GAME_FINISHED
            # TODO(xiaomin): set up text
        
        elif gameStatus == GameStatus.GAME_PLAYER_2_FOLD_RESULT:
            gameStatus = GameStatus.GAME_FINISHED
            # TODO(xiaomin): set up text
        
        # check for quit (typically the Esc key)
        if event.getKeys(keyList=["escape"]):#endExpNow: #or 
            win.close()
            win1.close()
            core.quit()
        
        
        win.flip()
        win1.flip()
        # check if all components have finished
        if gameStatus == GameStatus.GAME_FINISHED:  # a component has requested a forced-end of Routine
            core.wait(2)
            break
    
    # -------Ending Routine "trial"-------
    for thisComponent in trialComponents:
        if hasattr(thisComponent, "setAutoDraw"):
            thisComponent.setAutoDraw(False)
    # check responses
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