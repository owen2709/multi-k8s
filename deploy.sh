docker build -t stephengrinder/multi-client-k8s:latest -t stephengrinder/multi-client-k8s:$SHA -f ./client/Dockerfile ./client
docker build -t stephengrinder/multi-server-k8s-pgfix:latest -t stephengrinder/multi-server-k8s-pgfix:$SHA -f ./server/Dockerfile ./server
docker build -t stephengrinder/multi-worker-k8s:latest -t stephengrinder/multi-worker-k8s:$SHA -f ./worker/Dockerfile ./worker

docker push stephengrinder/multi-client-k8s:latest
docker push stephengrinder/multi-server-k8s-pgfix:latest
docker push stephengrinder/multi-worker-k8s:latest

docker push stephengrinder/multi-client-k8s:$SHA
docker push stephengrinder/multi-server-k8s-pgfix:$SHA
docker push stephengrinder/multi-worker-k8s:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=stephengrinder/multi-server-k8s-pgfix:$SHA
kubectl set image deployments/client-deployment client=stephengrinder/multi-client-k8s:$SHA
kubectl set image deployments/worker-deployment worker=stephengrinder/multi-worker-k8s:$SHA