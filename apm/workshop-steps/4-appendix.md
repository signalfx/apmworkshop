
#### Appendix A: Spin up Ubuntu VM on Mac or Windows  

[Multipass](http://multipass.run) deploys and runs Ubuntu virtual machines easily on Mac and Windows.  

Workshop examples have been tested on this configuration:

`multipass launch -n primary -d 12G -m 6G`

Make sure to always run `sudo apt-get -y update` before executing any step in the workshop.

#### Appendix B: Kubernetes Cluster Setup Hints

k3s is a lightweight Kubernetes deployment from Rancher: https://k3s.io/  

To k3s install on Linux:  
```
curl -sfL https://get.k3s.io | sh -
sudo chmod 644 /etc/rancher/k3s/k3s.yaml  
export KUBECONFIG=/etc/rancher/k3s/k3s.yaml  
```

Every time you re-enter a shell you'll need to:   
`export KUBECONFIG=/etc/rancher/k3s/k3s.yaml`

The stock configuration of k3s and this workshop's k8s examples have been tested on the following configurations:  

* [k3s](http://k3s.io) cluster (default settings) on Ubuntu VM:
  1. Macbook Pro 32GB RAM, Windows 10 Laptop 12GB RAM: [Multipass](http://multipass.run) started with `multipass launch -n primary -d 8G -m 4G`  
  2. AWS EC2
  
The Kubernetes lab has also been tested on:    
* Azure: Kubernetes 1.17.9 Azure Kubernetes Service  
* EKS / GKE: Not tested yet but 99.9% chance will have no issues  
* Workshop will NOT work on: Macbook Pro Docker Desktop Kubernetes


#### Appendix C: use tmux instead of separate terminal windows/tabs  

`tmux` is recommended to split your terminal into several panes so that you can run an application in each pane without having to containerize applications- and you can keep a separate pane open for checking status of spans, the host, etc.

**Important: each pane runs as its own bash shell so environment variables must be set in each pane. The workshop includes setup shell scripts to make it easy to do this.**

To install tmux: `sudo apt-get install tmux`

Tmux works by using `ctrl-b` as a command key followed by:
`"` make a new horizontal pane
`%` make a new vertical pane
Arrow keys: move between panes.
