sudo apt-get -y update
sudo apt-get -y install apt-transport-https ca-certificates curl gnupg-agent software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get -y update
sudo apt-get -y install docker-ce docker-ce-cli containerd.io

sudo apt-get install -y nodejs

sudo apt install -y openjdk-8-jdk
sudo apt-get -y install maven
curl -sfL https://get.k3s.io | sh -
sudo chmod 644 /etc/rancher/k3s/k3s.yaml
export KUBECONFIG=/etc/rancher/k3s/k3s.yaml

sudo apt install -y python3-pip
python3 -m pip install splunk-opentelemetry flask requests
export PATH="$HOME/.local/bin:$PATH"
splk-py-trace-bootstrap

git clone https://github.com/signalfx/apmworkshop
