# requires dockerhub login
sudo docker build . -f dotnet.dockerfile -t splk-dotnet5 && \
sudo docker tag splk-dotnet5 stevelsplunk/splk-dotnet5 && \
sudo docker push stevelsplunk/splk-dotnet5