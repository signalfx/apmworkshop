Set up an existing clean Ubuntu system or on your Multipass VM: 

`bash <(curl -s https://raw.githubusercontent.com/signalfx/apmworkshop/master/setup-tools/ubuntu.sh)`

Set up an existing clean Debian Linux system with only the k8s tooling:

`bash <(curl -s https://raw.githubusercontent.com/signalfx/apmworkshop/master/setup-tools/k8s-only.sh)`

Set up a multipass instance called "primary":

`bash <(curl -s https://raw.githubusercontent.com/signalfx/apmworkshop/master/setup-tools/multipass.sh)`

## If you want to use Minikube instead of k3s (optional)

`bash <(curl -s https://raw.githubusercontent.com/signalfx/apmworkshop/master/setup-tools/minikube.sh)`