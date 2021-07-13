# requires dockerhub login
sudo docker build . -f splk-dotnet.dockerfile -t splk-dotnet && \
sudo docker tag splk-dotnet stevelsplunk/splk-dotnet && \
sudo docker push stevelsplunk/splk-dotnet