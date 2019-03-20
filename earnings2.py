#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Thu Mar 14 17:22:08 2019

@author: virginiafedrigo
"""


#import csv
#import numpy as np
import pandas
import sys
import numpy as np
def paymentOutput(path,filename):
	df = pandas.read_csv(path+filename, header = 0)
	   
	df = df.drop(columns = ['trials.thisRepN','trials.thisTrialN', 'trials.thisN', 'trials.thisIndex','SubjectNO', 'date', 
	    'expName', 'psychopyVersion', 'frameRate', 'SubjectInitials', 'Unnamed: 16'])

	df = df.drop([0, 1, 2])

	df = df.rename(index=str, columns={"player1ActionCheck.keys": "player1ActionCheck", "player2ActionCheck.keys": "player2ActionCheck",
	                              "player1ActionCheck.rt" : "player1RT", "player2ActionCheck.rt" : "player2RT"})


	whoHigher = df.P1card > df.P2card #true when P1 has the bigger card
	p1Move = (1)*(df.player1ActionCheck == 'b') + (-1)*(df.player1ActionCheck == 'None')
	p2Move = (1)*(df.player2ActionCheck == 'c') + (-1)*(df.player2ActionCheck == 'None')
	moveSum = p1Move + p2Move
	betCall = ((p1Move == 1) & (p2Move == 1))
	betFold = ((p1Move == 1) & (p2Move == 0))
	check = ((p1Move == 0) & (p2Move == -1))
	noActionBoth = (moveSum == -2)

	p1WinBetCall = 3*((betCall == 1) & (whoHigher == 1))
	p1WinCheck = 1*((whoHigher == 1) & (check == 1))
	p1WinNoMove = 2*((p1Move == 1) & (p2Move == -1))
	p1Wins = p1WinBetCall + p1WinNoMove + p1WinCheck + betFold

	p1LoseBetCall = (-3)*((betCall == 1) & (whoHigher == 0))
	p1LoseCheck = (-1)*((whoHigher == 0) & (check == 1))
	p1NoMove = (-2)*(p1Move == -1)
	p1Losses =  p1LoseBetCall + p1LoseCheck + p1NoMove

	p1Earnings = p1Wins + p1Losses

	p2WinBetCall = (3*((betCall == 1) & (whoHigher == 0)))
	p2WinCheck = ((whoHigher == 0) & (check == 1))
	p2WinNoMove = (2)*(p1Move == -1)
	p2Wins = p2WinBetCall + p2WinCheck + p2WinNoMove

	p2LoseBetCall = (-3)*((betCall == 1) & (whoHigher == 1))
	p2LoseCheck = (-1)*((whoHigher == 1) & (check == 1))
	p2NoMove = (-2)*((p1Move == 1) & (p2Move == -1))
	p2Fold = (-1)*((p1Move == 1) & (p2Move == 0))
	p2Losses =  p2LoseBetCall + p2LoseCheck + p2Fold + p2NoMove


	p2Earnings = p2Wins + p2Losses
	p2EarningsFinal = p2Earnings.sample(frac = 0.1)
	p1EarningsFinal = p1Earnings.sample(frac = 0.1)
	p1output = p1EarningsFinal.sum()
	p2output = p2EarningsFinal.sum()
	return(p1output,p2output)