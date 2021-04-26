export KUBECONFIG=/etc/rancher/k3s/k3s.yaml && \
sudo chmod 644 /etc/rancher/k3s/k3s.yaml  
helm install -f values.yaml signalfx-agent signalfx/signalfx-agent
