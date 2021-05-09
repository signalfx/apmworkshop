kubectl delete deployment server-flask-otel-k8s	&
kubectl delete service server-flask-otel-k8s &
kubectl delete pod server-flask-otel-k8s &

kubectl delete deployment client-py-otel-k8s &
kubectl delete service client-py-otel-k8s &
kubectl delete pod client-py-otel-k8s &

kubectl delete deployment client-java-otel-k8s &
kubectl delete service client-java-otel-k8s &
kubectl delete pod client-java-otel-k8s &

kubectl delete deployment java-manual-inst-k8s &
kubectl delete service java-manual-inst-k8s &
kubectl delete pod java-manual-inst-k8s &