sudo apt-get -y update

#install helm
curl -s https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash

#install otel
helm repo add splunk-otel-collector-chart https://signalfx.github.io/splunk-otel-collector-chart
helm repo update

#enable helm to access cluster
mkdir /home/ubuntu/.kube && sudo sudo kubectl config view --raw > /home/ubuntu/.kube/config

#install text browser
sudo apt install -y lynx

#clone workshop
git clone https://github.com/signalfx/apmworkshop

#update .bashrc for workshop
echo -e "\n\n" >> /home/ubuntu/.bashrc
cat bashrc >> /home/ubuntu/.bashrc
source /home/ubuntu/.bashrc