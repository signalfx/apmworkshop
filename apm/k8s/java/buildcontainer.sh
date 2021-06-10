# requires dockerhub login
curl -L https://github.com/signalfx/splunk-otel-java/releases/latest/download/splunk-otel-javaagent-all.jar -o ./splunk-otel-javaagent.jar
sudo docker build . -f dockerfile-java -t splk-java
sudo docker tag splk-java stevelsplunk/splk-java
sudo docker push stevelsplunk/splk-java
rm ./splunk-otel-javaagent.jar