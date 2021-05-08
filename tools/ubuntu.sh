#install Node
sudo apt-get install -y nodejs
sudo apt install -y npm

#install Java
sudo apt install -y openjdk-8-jdk
#sudo apt-get -y install maven

#install k3s
curl -sfL https://get.k3s.io | sh -
sudo chmod 644 /etc/rancher/k3s/k3s.yaml
export KUBECONFIG=/etc/rancher/k3s/k3s.yaml

#install python pip
sudo apt install -y python3-pip

#install python dependencies 
python3 -m pip install splunk-opentelemetry flask requests redis
export PATH="$HOME/.local/bin:$PATH"
splk-py-trace-bootstrap

#install helm
sudo snap install helm --classic
helm repo add signalfx https://dl.signalfx.com/helm-repo
helm repo update

#clone workshop
git clone https://github.com/signalfx/apmworkshop
