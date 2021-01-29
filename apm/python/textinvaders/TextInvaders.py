import time
import signal
import GetInput
from random import randint
from Classes import Board
from Classes import Spaceship
from Classes import Missile
from Classes import Alien


class Engine(Board, Spaceship, Missile, Alien):
    '''game engine that inherits from classes
       Board, Spaceship, Missile, Alien'''
    def __init__(self):
        self.board = Board()
        self.myShip = Spaceship('$', 56, self.board)
        self.miss1 = []
        self.miss2 = []
        self.aliens = []
        self.score = 0
        self.start = time.time()
        self.getch = GetInput._getChUnix()

    #method that returns the alien 
    #object at a given position 
    #when a missile collides with 
    #the alien at that position
    def findalien(self, pos):
        for i in self.aliens:
            if i.pos == pos:
                return i

    #method to update the gameboard
    def updateboard(self):
        delmiss = []
        delaliens = []

        #update positions of missiles
        for i in self.miss1:

            if time.time() - i.time >= 1:

                if self.board.grid[i.pos] == i.ch:
                    self.board.grid[i.pos] = ' '
                i.pos -= i.jump

                if i.pos < 0:
                    delmiss.append(i)
                    continue

                if self.board.grid[i.pos] == 'A':
                    delmiss.append(i)
                    self.score += 10
                    self.board.grid[i.pos] = ' '
                    alien_obj = self.findalien(i.pos)
                    delaliens.append(alien_obj)
                    continue

                elif self.board.grid[i.pos] == '@':
                    delmiss.append(i)
                    self.score += 5
                    self.board.grid[i.pos] = ' '
                    alien_obj = self.findalien(i.pos)
                    delaliens.append(alien_obj)
                    continue

                else:
                    i.time = time.time()
                    self.board.grid[i.pos] = i.ch

        for i in delmiss:
            self.miss1.remove(i)

        delmiss = []
        for i in self.miss2:

            if time.time() - i.time >= 1:

                if self.board.grid[i.pos] == i.ch:
                    self.board.grid[i.pos] = ' '
#
                i.pos -= int((i.jump) / 2)
                print(i.pos)
                if i.pos < 0:
                    delmiss.append(i)
                    continue

                if self.board.grid[i.pos] == 'A':
                    delmiss.append(i)
                    self.board.grid[i.pos] = '@'
                    alien_obj = self.findalien(i.pos)
                    alien_obj.time += 5
                    continue

                elif self.board.grid[i.pos] == '@':
                    delmiss.append(i)
                    self.board.grid[i.pos] = ' '
                    alien_obj = self.findalien(i.pos)
                    alien_obj.time += 5
                    continue

                else:
                    pass
#
                i.pos -= int((i.jump) / 2)

                if i.pos < 0:
                    delmiss.append(i)
                    continue

                if self.board.grid[i.pos] == 'A':
                    delmiss.append(i)
                    self.board.grid[i.pos] = '@'
                    alien_obj = self.findalien(i.pos)
                    alien_obj.time += 5
                    continue

                elif self.board.grid[i.pos] == '@':
                    delmiss.append(i)
                    self.board.grid[i.pos] = ' '
                    alien_obj = self.findalien(i.pos)
                    alien_obj.time += 5
                    continue

                else:
                    i.time = time.time()
                    self.board.grid[i.pos] = i.ch

        for i in delmiss:
            self.miss2.remove(i)

        #remove aliens that have been
        #on the board for ten seconds
        for i in self.aliens:
            if time.time() - i.time >= 10:
                delaliens.append(i)
                self.board.grid[i.pos] = ' '

        for i in delaliens:
            try:
                self.aliens.remove(i)
            except ValueError:
                pass

        #spawning three aliens randomly
        #after every seven seconds
        if time.time() - self.start >= 7:
            self.start = time.time()
            for _ in range(3):
                newalien = Alien('A', '@', randint(0, 15), time.time())
                self.board.grid[newalien.pos] = newalien.ch1
                self.aliens.append(newalien)

        del delaliens
        del delmiss

    def run(self):

        def alarmhandler(signum, frame):
            raise TypeError

        def getinp(timeout=0.5):
            signal.signal(signal.SIGALRM, alarmhandler)
            signal.setitimer(signal.ITIMER_REAL, timeout)
            try:
                ch = self.getch()
                signal.alarm(0)
                return ch
            except TypeError:
                pass
            signal.signal(signal.SIGALRM, signal.SIG_IGN)
            return ''

        for _ in range(4):
            newalien = Alien('A', '@', randint(0, 15), time.time())
            self.board.grid[newalien.pos] = newalien.ch1
            self.aliens.append(newalien)

        while True:

            self.board.render()

            print ('YOUR SCORE:', self.score)

            inp = getinp()

            if inp == 'a':
                self.myShip.moveLeft()

            elif inp == 'd':
                self.myShip.moveRight()

            elif inp == 's':
                newmissile = Missile('l', self.myShip.pos-8, time.time(), 2)
                self.board.grid[self.myShip.pos-8] = 'l'
                self.board.render()
                self.miss2.append(newmissile)

            elif inp == 'q':
                print('Thank you for playing Trace Invaders: ASCII Edition')
                exit()

            else:
                pass

            self.updateboard()
