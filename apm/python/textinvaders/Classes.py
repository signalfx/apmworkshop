#module containing various classes#

import os

class Board:
    #creates an 8X8 board#

    def __init__(self):
        self.grid = [' '] * 64

    def getGrid(self):
        return self.grid

    @staticmethod
    def printBoundary():
        str = '         '
        print('{}-----------------'.format(str))

    @staticmethod
    def printRow(r):
        str = '         '
        print('{}|{} {} {} {} {} {} {} {}|'.format(
            str, r[0], r[1], r[2], r[3], r[4], r[5], r[6], r[7]))

    def render(self):
        os.system('tput reset')
        Board.printBoundary()
        for i in range(8):
            Board.printRow(self.grid[i * 8:i * 8 + 8])
        Board.printBoundary()
        print('\n\n')

class Spaceship:
    #cretes an instance of the spaceship#

    def __init__(self, ch, pos, board):
        self.ch = ch
        self.pos = pos
        self.board = board
        self.board.grid[56] = ch

    def moveLeft(self):
        #moves the spaceship to the left#
        if self.pos > 56:
            self.board.grid[self.pos] = ' '
            self.board.grid[self.pos - 1] = self.ch
            self.pos = self.pos - 1
            self.board.render()

    def moveRight(self):
        #moves the spaceship to the right#
        if self.pos < 63:
            self.board.grid[self.pos] = ' '
            self.board.grid[self.pos + 1] = self.ch
            self.pos = self.pos + 1
            self.board.render()


class Missile:
    #creates two types of missiles, 
    #  one that moves two rows up and
    #  the other, one row up after certain
    #  time interval#

    def __init__(self, ch, pos, time, jump):
        self.ch = ch
        self.pos = pos
        self.time = time
        self.jump = 8 * jump


class Alien:
    #creates an alien represented
    #  by some special character#

    def __init__(self, ch1, ch2, pos, time):
        self.ch1 = ch1
        self.ch2 = ch2
        self.pos = pos
        self.time = time
