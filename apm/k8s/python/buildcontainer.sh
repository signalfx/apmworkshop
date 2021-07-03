# requires dockerhub login
sudo docker build . -f splk-otel-python.dockerfile -t splk-python && \
sudo docker tag splk-python stevelsplunk/splk-python && \
sudo docker push stevelsplunk/splk-python