#install k3s
curl -sfL https://get.k3s.io | sh -
sudo chmod 644 /etc/rancher/k3s/k3s.yaml
export KUBECONFIG=/etc/rancher/k3s/k3s.yaml

#install helm
sudo snap install helm --classic
helm repo add signalfx https://dl.signalfx.com/helm-repo
helm repo update

#clone workshop
git clone https://github.com/signalfx/apmworkshop

#update .bashrc for workshop
cat bashrc >> /home/ubuntu/.bashrc