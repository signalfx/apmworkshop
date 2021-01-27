# space.py
	

import turtle
import math
import random
import os
from sys import exit

from opentelemetry import trace

#create tracer
tracer = trace.get_tracer(__name__)

# Move player to the right
def move_right():
	x = player.xcor()
	x = x + playerspeed
	if x > 280:
		x = 280
	player.setx(x)

def move_left():
	x = player.xcor()
	x = x - playerspeed
	if x < -280:
		x = -280
	player.setx(x)

def leave_game():
	exit()

def fire_bullet():
	# Declare bulletstate as global variable
	global bulletstate
	if bulletstate == "ready":
		os.system("afplay laser.wav&")
		bulletstate = "fire"
		# Move bullet to just above the player
		x = player.xcor()
		y = player.ycor() + 10
		bullet.goto(x, y)
		bullet.showturtle()

def is_collision(obj1, obj2):
	distance = math.sqrt((obj1.xcor() - obj2.xcor()) ** 2 + (obj1.ycor() - obj2.ycor()) ** 2)
	
	if distance < 15:
		return True
	else:
		return False

# Set up the screen
wn = turtle.Screen()
wn.bgcolor("black")
wn.title("Trace Invaders by Splunk")
wn.setup(800, 800, startx = None, starty = None)
wn.bgpic("trace_invaders_background.gif")

# Register the shapes
turtle.register_shape("player.gif")
turtle.register_shape("invader.gif")

# Draw border
border_pen = turtle.Turtle()
border_pen.speed(0)
border_pen.color("white")
border_pen.hideturtle()
border_pen.pensize(3)
border_pen.up()
border_pen.goto(-300, -300)
border_pen.down()
for side in range(4):
	border_pen.forward(600)
	border_pen.left(90)

# Set score to zero
score = 0

# Draw the score
score_pen = turtle.Turtle()
score_pen.speed(0)
score_pen.color("white")
score_pen.up()
score_pen.goto(-290, 250)
score_string = "Score: {}".format(score)
score_pen.write(score_string, False, align="left", font=("Arial", 14, "normal"))
score_pen.hideturtle()

# Create the player
player = turtle.Turtle()
player.color("blue")
player.shape("player.gif")
player.speed(0)
player.up()
player.goto(0, -250)
player.setheading(90)

playerspeed = 15

# Choose the number of enemies
number_of_enemies = 5

# Create an empty list of enemies
enemies = []

# Add enemies to list
for i in range(number_of_enemies):
	# Create enemy
	enemies.append(turtle.Turtle())

for enemy in enemies:
	enemy.color("red")
	enemy.shape("invader.gif")
	enemy.speed(0)
	enemy.up()
	x = random.randint(-200, 200)
	y = random.randint(100, 250)
	enemy.goto(x, y)

enemyspeed = 2

# Create bullet
bullet = turtle.Turtle()
bullet.color("yellow")
bullet.shape("triangle")
bullet.shapesize(0.25, 0.5)
bullet.speed(0)
bullet.setheading(90)
bullet.up()
bullet.goto(0, -400)
bullet.hideturtle()

bulletspeed = 20

# Define bullet state
# ready - ready to fire
# fire - bullet is firing
bulletstate = "ready"

# Create keyboard bindings
turtle.listen()
turtle.onkey(move_right, "Right")
turtle.onkey(move_left, "Left")
turtle.onkey(fire_bullet, "space")
turtle.onkey(leave_game, "q")

# Main Game Loop
while True:

	for enemy in enemies:
			
		# Move the enemy
		x = enemy.xcor()
		x = x + enemyspeed
		enemy.setx(x)

		# Move enemy back and down
		if enemy.xcor() > 280:
			for e in enemies:
				y = e.ycor()
				y = y - 40
				e.sety(max(y, -250))		# Keep enemy from going below the level of the player
			enemyspeed = enemyspeed * -1
			with tracer.start_as_current_span("AlienMovement"):
				current_span = trace.get_current_span()
				current_span.set_attribute("span.kind", "SERVER")
				current_span.set_attribute("error", "true")
			# end parent span

		if enemy.xcor() < -280:
			for e in enemies:
				y = e.ycor()
				y = y - 40
				e.sety(max(y, -250))		# Keep enemy from going below the level of the player
			enemyspeed = enemyspeed * -1
			with tracer.start_as_current_span("AlienMovement"):
				current_span = trace.get_current_span()
				current_span.set_attribute("span.kind", "SERVER")
				current_span.set_attribute("error", "true")
			# end parent span

		# Check for collision between bullet and enemy
		if is_collision(bullet, enemy):
			os.system("afplay explosion.wav&")
			# Reset the bullet
			bullet.hideturtle()
			bulletstate = "ready"
			bullet.goto(0, -400)
			# Reset the enemy
			x = random.randint(-200, 200)
			y = random.randint(100, 250)
			enemy.goto(x, y)
			# Update the score
			score += 10
			score_string = "Score: {}".format(score)
			score_pen.clear()
			score_pen.write(score_string, False, align="left", font=("Arial", 14, "normal"))
			with tracer.start_as_current_span("AlienHit"):
				current_span = trace.get_current_span()
				current_span.set_attribute("span.kind", "SERVER")

		# Check for collision between enemy and player
		if is_collision(enemy, player):
			player.hideturtle()
			enemy.hideturtle()
			enemy.goto(-100, 0)
			enemy.write("Game Over!!", font=("Helvetica", 36, "normal"))
			print("Game Over")
			break

	# Move the bullet
	if bulletstate == "fire":
		y = bullet.ycor()
		y = y + bulletspeed
		bullet.sety(y)

	# Check if bullet has gone to the top
	if bullet.ycor() > 280:
		bullet.hideturtle()
		bulletstate = "ready"

delay = input("Press ENTER to end.")
