#module to take input#

class _getChUnix:
    #class to take input#

    def __init__(self):
        #init def to take input#
        import tty
        import sys

    def __call__(self):
        #def to call function#
        import sys
        import tty
        import termios
        fedvar = sys.stdin.fileno()
        old_settings = termios.tcgetattr(fedvar)
        try:
            tty.setraw(sys.stdin.fileno())
            charvar = sys.stdin.read(1)
        finally:
            termios.tcsetattr(fedvar, termios.TCSADRAIN, old_settings)
        return charvar
