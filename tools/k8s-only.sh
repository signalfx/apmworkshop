sudo apt-get -y update
curl -sfL https://get.k3s.io | sh -
sudo chmod 644 /etc/rancher/k3s/k3s.yaml
export KUBECONFIG=/etc/rancher/k3s/k3s.yaml

sudo snap install helm --classic
helm repo add signalfx https://dl.signalfx.com/helm-repo
helm repo update

git clone https://github.com/signalfx/apmworkshop
