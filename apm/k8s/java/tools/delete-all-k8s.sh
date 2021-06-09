sudo kubectl delete deployment server-flask-otel-k8s &
sudo kubectl delete service server-flask-otel-k8s &
sudo kubectl delete pod server-flask-otel-k8s &

sudo kubectl delete deployment client-py-otel-k8s &
sudo kubectl delete service client-py-otel-k8s &
sudo kubectl delete pod client-py-otel-k8s &

sudo kubectl delete deployment client-java-otel-k8s &
sudo kubectl delete service client-java-otel-k8s &
sudo kubectl delete pod client-java-otel-k8s &

sudo kubectl delete deployment java-manual-inst-k8s &
sudo kubectl delete service java-manual-inst-k8s &
sudo kubectl delete pod java-manual-inst-k8s &