# requires dockerhub login
sudo docker build . -f dockerfile-java -t sfx-java
sudo docker tag sfx-java stevelsplunk/sfx-java
sudo docker push stevelsplunk/sfx-java
