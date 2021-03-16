# requires dockerhub login
sudo docker build . -f dockerfile-splk-otel-python-autogen -t splk-python-autogen && \
sudo docker tag splk-python stevelsplunk/splk-python-autogen && \
sudo docker push stevelsplunk/splk-python-autogen
