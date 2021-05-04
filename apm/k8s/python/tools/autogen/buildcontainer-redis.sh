# requires dockerhub login
sudo docker build . -f dockerfile-redis -t redis && \
sudo docker tag redis stevelsplunk/redis && \
sudo docker push stevelsplunk/redis