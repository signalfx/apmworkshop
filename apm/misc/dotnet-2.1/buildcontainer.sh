# requires dockerhub login
sudo docker build . -f dotnet-2.1.dockerfile -t splk-dotnet-2.1 && \
sudo docker tag splk-dotnet-2.1 stevelsplunk/splk-dotnet-2.1 && \
sudo docker push stevelsplunk/splk-dotnet-2.1