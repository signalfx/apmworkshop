# requires dockerhub login
sudo docker build . -f dockerfile-test -t test-platform && \
sudo docker tag test-platform stevelsplunk/redis test-platform \
sudo docker push stevelsplunk/test-platform