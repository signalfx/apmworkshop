# otcollector.py
import time
from time import sleep
from random import random
from random import seed

from opentelemetry import trace

seed(1)
x=1
tracer = trace.get_tracer(__name__)

while x:
	y = random()*2
	sleep(y)
	with tracer.start_as_current_span("parent"):
		current_span = trace.get_current_span()
		current_span.set_attribute("span.kind", "SERVER")
		print("span", x)
	# close child
#    	x=x+1
