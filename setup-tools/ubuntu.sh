#install Node
sudo apt-get install -y nodejs
sudo apt install -y npm

#install Java
sudo apt install -y openjdk-8-jdk
#sudo apt-get -y install maven

#install python pip
sudo apt install -y python3-pip

#install python dependencies 
python3 -m pip install requirements.txt
export PATH="$HOME/.local/bin:$PATH"
splk-py-trace-bootstrap

#install k3s
curl -sfL https://get.k3s.io | sh -
sudo chmod 644 /etc/rancher/k3s/k3s.yaml
export KUBECONFIG=/etc/rancher/k3s/k3s.yaml

#install helm
sudo snap install helm --classic
helm repo add splunk-otel-collector-chart https://signalfx.github.io/splunk-otel-collector-chart
helm repo update

#clone workshop
git clone https://github.com/signalfx/apmworkshop

#update .bashrc for workshop
echo -e "\n\n" >> /home/ubuntu/.bashrc
cat bashrc >> /home/ubuntu/.bashrc
source /home/ubuntu/.bashrc