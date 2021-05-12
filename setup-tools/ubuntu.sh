sudo apt-get -y update

#install helm
curl -s https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash

#install k3s
curl -sfL https://get.k3s.io | sh -

#install otel
helm repo add splunk-otel-collector-chart https://signalfx.github.io/splunk-otel-collector-chart
helm repo update

#install Node
sudo apt-get install -y nodejs
sudo apt install -y npm

#install Java
sudo apt install -y openjdk-8-jdk
#sudo apt-get -y install maven

#install python pip
sudo apt install -y python3-pip

#install python dependencies 
python3 -m pip install -r requirements.txt
splk-py-trace-bootstrap

#enable helm to access cluster
sudo kubectl config view --raw > $HOME/.kube/config

#install text browser
sudo apt install -y lynx

#clone workshop
git clone https://github.com/signalfx/apmworkshop