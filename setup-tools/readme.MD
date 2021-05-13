Set up workshop on an existing clean Ubuntu system or on your Multipass VM: 

`bash <(curl -s https://raw.githubusercontent.com/signalfx/apmworkshop/master/setup-tools/ubuntu.sh)`

Set up only k3s workshop components on clean Ubuntu system:

`bash <(curl -s https://raw.githubusercontent.com/signalfx/apmworkshop/master/setup-tools/k3s-env-only.sh)`

If you already have k8s installed on Ubuntu:

`bash <(curl -s https://raw.githubusercontent.com/signalfx/apmworkshop/master/setup-tools/k8s-env-only.sh)`

Set up a multipass instance called "primary":

`bash <(curl -s https://raw.githubusercontent.com/signalfx/apmworkshop/master/setup-tools/multipass.sh)`

## If you want to use Minikube instead of k3s (optional)

`bash <(curl -s https://raw.githubusercontent.com/signalfx/apmworkshop/master/setup-tools/minikube.sh)`