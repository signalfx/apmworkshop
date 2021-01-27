# Python Trace Invaders by Splunk and OpenTelemetry

<img src="./screenshot.png" width="640">

This is designed for MacOS only at this time.

### Step #1

Set up your Mac for Splunk Python OpenTelemetry- make sure you don't have conflicting Python OpenTelemetry packages:

```
sudo apt install -y python3-pip && \
python3 -m pip install splunk-opentelemetry && \
export PATH="$HOME/.local/bin:$PATH" && \
splk-py-trace-bootstrap
```

### Step #2

Set up your Splunk APM REALM and TOKEN by editing: `setup.sh` and then run the setup script: `source setup.sh`

### Step #3 Run Game

To run game: `source startgame.sh`

**Instructions**

The Splunk APM Service Dashboard for TraceInvaders shows a req/sec every time you hit an alien.

Every time the aliens advance downwards towards you, an error span is generated.
The goal is to keep the reqs/sec high and the error spans at zero.

Exit by closing game window or ctrl-c in terminal.

This is a project written originally by Christian Thompson (http://christianthompson.com/node/45) in Python 2. And was rewritten in Python 3 here: https://github.com/samkoe/space_invaders and further modified by Splunk for OpenTelemetry and branding.
