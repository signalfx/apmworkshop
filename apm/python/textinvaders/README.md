# Space Invaders ( a terminal - based arcade game )
*Coded by* : **Preet Thakkar** 
*Language* : **Python**
--------------------------------------------------------------------------------
### About The Game
Space Invaders (Japanese: スペースインベーダー Hepburn: Supēsu Inbēdā) is an arcade game created by Tomohiro Nishikado and released in 1978. It was manufactured and sold by Taito in Japan, and licensed in the United States by the Midway division of Bally. Space Invaders is one of the earliest shooting games; the aim is to defeat waves of aliens with a laser to earn as many points as possible.
        
### Rules
* You will be controlling a spaceship(denoted by '$' character) that can move only in horizontal direction. It can shoot two types of missiles, one faster than the other.
* Aliens(denoted by 'A' character) will spawn at random locations of the gameboard and stay for short time. All you have to do is hit the aliens with your missiles. 
* You score a 10 when you hit an alien with the slower missile(denoted bi 'i' character). The faster missile(denoted by 'l' character) just increases the life span of an alien(i.e. does not earn you any points).

### Instructions to play 
* Run the following command to start the game.
    ```sh
    $ python run.py
    ```
* Press any key(except 'q') to start the game.
* Press 'q' to quit.
* Use 'a' and 'd' to control the spaceship.
* Use 'w' to shoot the slower missile.
* Use 's' to shoot the faster missile.

### Requirements
* The only requirement is **Python**. Installation details:
For Linux:
    ```sh
    $ sudo apt-get update
    $ sudo apt-get install python
    ```
    For mac:
    ```sh
    $ brew cask update
    $ sudo brew cask install python
    ```