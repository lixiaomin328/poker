import sys
from sys import exit
import random
from random import randrange
import tkinter as tk
import tkinter.messagebox
from tkinter import *

from PIL import Image,ImageTk

##########dilog#########
window1=tk.Tk()
window1.title('player1')
window1.geometry('400x800+100+20')
window2 = tk.Toplevel()
window2.title('player2')
window2.geometry('400x800+500+20')

############poker############
cards=['10','J','Q','K','A']
pics={'10':'10.gif','J':'J.gif','Q':'Q.gif','K':'K.gif','A':'A.gif'}


def cardFun():
    global im1,label1,im2,label2,a,b,card1,card2
    a=b=-1
    im1=label1=None
    im2=label2=None
    window1.update()
    window2.update()
    random.shuffle(cards)
    card1=random.choice(cards)
    card2=random.choice(cards)
    im1=PhotoImage(file=pics[card1])
    label1=tk.Label(window1,image=im1).place(x=200,y=50)
    im2=PhotoImage(file=pics[card2])
    label2=tk.Label(window2,image=im2).place(x=200,y=50)

b5=tk.Button(window1,text='deal',width=4,height=4,command=cardFun)
b5.pack(side='bottom')

##############bet or not###########
order={'10':1,'J':2,'Q':3,'K':4,'A':5}

def a_compare():
    global a,b,card1,card2
    a=1
    if b==1:
        if order[card1]>order[card2]:
            tk.messagebox.showinfo('result','A wins')
        if order[card1]<order[card2]:
            tk.messagebox.showinfo('result','B wins')
        if order[card1]==order[card2]:
            tk.messagebox.showinfo('result','tied')
    if b==0:
        tk.messagebox.showinfo('result','A wins')

def a_not_compare():
    global a,b
    a=0
    if b==0:
        if order[card1]<order[card2]:
            tk.messagebox.showinfo('result','A wins')
        if order[card1]>order[card2]:
            tk.messagebox.showinfo('result','B wins')
        if order[card1]==order[card2]:
            tk.messagebox.showinfo('result','tied')
    if b==1:
        tk.messagebox.showinfo('result','B wins')

def b_compare():
    global a,b,card1,card2
    b=1
    if a==1:
        if order[card1]>order[card2]:
            tk.messagebox.showinfo('result','A wins')
        if order[card1]<order[card2]:
            tk.messagebox.showinfo('result','B wins')
        if order[card1]==order[card2]:
            tk.messagebox.showinfo('result','tied')
    if a==0:
        tk.messagebox.showinfo('result','B wins')
def b_not_compare():
    global a,b
    b=0
    if a==0:
        if order[card1]<order[card2]:
            tk.messagebox.showinfo('result','A wins')
        if order[card1]>order[card2]:
            tk.messagebox.showinfo('result','B wins')
        if order[card1]==order[card2]:
            tk.messagebox.showinfo('result','tied')
    if a==1:
        tk.messagebox.showinfo('result','A wins')

###############response###########
b1=tk.Button(window1,text='bet',width=4,height=10,command=a_compare)
b1.pack(side='left')
b2=tk.Button(window1,text='not bet',width=4,height=10,command=a_not_compare)
b2.pack(side='right')
b3=tk.Button(window2,text='bet',width=4,height=10,command=b_compare)
b3.pack(side='left')
b4=tk.Button(window2,text='not bet',width=4,height=10,command=b_not_compare)
b4.pack(side='right')

########keep the window#######
window1.mainloop()
window2.mainloop()
