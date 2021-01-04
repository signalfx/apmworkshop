# requires dockerhub login
sudo docker build . -f dockerfile-java -t splk-java
sudo docker tag splk-java stevelsplunk/splk-java
sudo docker push stevelsplunk/splk-java
