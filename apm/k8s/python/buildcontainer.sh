# requires dockerhub login
sudo docker build . -f dockerfile-python -t sfx-python
sudo docker tag sfx-java stevelsplunk/sfx-python
sudo docker push stevelsplunk/sfx-python
