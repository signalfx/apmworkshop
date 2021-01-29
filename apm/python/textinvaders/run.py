import TextInvaders
from GetInput import _getChUnix as getinp
import os

#creating an instance of the game engine
myEngine = TextInvaders.Engine()

#general instructions to play the game
os.system('tput reset')
print('----------------- Welcome to Trace Invaders ASCII Edition --------------\n')
print('Instructions:')
print('press "a" to move the spaceship to left')
print('press "d" to move the spaceship to right')
print('use "s" to shoot\n\n')
print('press any key to start the game')
print('press "q" to quit\n')

inp = getinp()
if inp() != 'q':
    myEngine.run()
else:
    print('Thank you for playing Trace Invaders: ASCII Edition')
