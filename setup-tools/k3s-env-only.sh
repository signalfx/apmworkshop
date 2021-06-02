sudo apt-get -y update

#install helm
curl -s https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash

#install k3s
curl -sfL https://get.k3s.io | sh -

#install otel
helm repo add splunk-otel-collector-chart https://signalfx.github.io/splunk-otel-collector-chart
helm repo update

#enable helm to access cluster
export KUBECONFIG=/etc/rancher/k3s/k3s.yaml
sudo chmod 755 /etc/rancher/k3s/k3s.yaml

#install text browser
sudo apt install -y lynx

#install k9s
curl -sS https://webinstall.dev/k9s | bash

#clone workshop
git clone https://github.com/signalfx/apmworkshop

#update .bashrc for workshop
curl https://raw.githubusercontent.com/signalfx/apmworkshop/master/setup-tools/bashrc -o bashrc
echo -e "\n\n" >> /home/ubuntu/.bashrc
cat bashrc >> /home/ubuntu/.bashrc
rm bashrc
source /home/ubuntu/.bashrc
