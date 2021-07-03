FROM python:slim
RUN mkdir /home/code
WORKDIR /home/code
COPY . /home/code/
RUN apt-get update && \
    export PATH="$HOME/.local/bin:$PATH" && \
    apt install -y python3-pip && \
    apt install -y curl && \    
    python3 -m pip install -r requirements.txt && \
    splk-py-trace-bootstrap && \
    apt -y autoremove && apt-get -y autoclean
EXPOSE 5000 9090

# apt install -y dnsutils && \
# apt install -y util-linux && \
# apt install -y coreutils && \