# Camerer Group Poker EEG Project
Author: Xiaomin Li, Daw-an Wu and Virginia Fedrigo

Main script for task, eeg and eyetracking: LabJackPython-master/mainExperiment.py
EEG API: LabJackPython
https://github.com/labjack/LabJackPython
Eye tracking API: eyelink
https://www.sr-support.com/showthread.php?14-Pylink

mTurk task code: poker/mTurkTaskCode, written in javascript. Task is the same, but but for behavior only.

Behavioral Data will be saved to:
LabJackPython-master/data
Refer to "02_poker_test_2019_Mar_12_1459.csv" for a pair of players. 02 is their pair ID. 

Eyetracking data will be saved to: 
LabJackPython-master/edfData

All EEG data will be saved to the lab computer that connected to the EEG device. You use a hard drive device to copy it manually.

We merged all previous behavioral data in poker/data

All eye-tracking previous data in poker/edfData

mTurk behavioral data: mTurk_data
(different set of code but same design)

All data processing script in: poker/data_processing scripts

poker/psPM: a python toolbox for pupil analysis, we didn't use it in the end.

Source Image for Experiment: poker/cards

contact Daw-An Wu for hardware problems.

 