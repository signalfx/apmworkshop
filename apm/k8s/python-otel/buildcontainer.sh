# requires dockerhub login
sudo docker build . -f dockerfile-splk-otel-python -t splk-python && \
sudo docker tag sfx-python stevelsplunk/splk-python && \
sudo docker push stevelsplunk/splk-python
