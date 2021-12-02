docker build -t owen2709/multi-client-k8s:latest -t owen2709/multi-client-k8s:$SHA -f ./client/Dockerfile ./client
docker build -t owen2709/multi-server-k8s-pgfix:latest -t owen2709/multi-server-k8s-pgfix:$SHA -f ./server/Dockerfile ./server
docker build -t owen2709/multi-worker-k8s:latest -t owen2709/multi-worker-k8s:$SHA -f ./worker/Dockerfile ./worker

docker push owen2709/multi-client-k8s:latest
docker push owen2709/multi-server-k8s-pgfix:latest
docker push owen2709/multi-worker-k8s:latest

docker push owen2709/multi-client-k8s:$SHA
docker push owen2709/multi-server-k8s-pgfix:$SHA
docker push owen2709/multi-worker-k8s:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=owen2709/multi-server-k8s-pgfix:$SHA
kubectl set image deployments/client-deployment client=owen2709/multi-client-k8s:$SHA
kubectl set image deployments/worker-deployment worker=owen2709/multi-worker-k8s:$SHA