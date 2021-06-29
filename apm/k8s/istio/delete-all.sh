kubectl delete deployment server-flask-otel-k8s &
kubectl delete service server-flask-otel-k8s &
kubectl delete pod client-py &
kubectl delete gateway flask-gateway &
kubectl delete virtualservice flask-service &