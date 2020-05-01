docker build -t catchsagar/multi-k8s-client:latest -t catchsagar/multi-k8s-client:$SHA -f ./client/Dockerfile ./client
docker build -t catchsagar/multi-k8s-server:latest -t catchsagar/multi-k8s-server:$SHA -f ./server/Dockerfile ./server
docker build -t catchsagar/multi-k8s-worker:latest -t catchsagar/multi-k8s-worker:$SHA -f ./worker/Dockerfile ./worker

docker push catchsagar/multi-k8s-client:latest
docker push catchsagar/multi-k8s-server:latest
docker push catchsagar/multi-k8s-worker:latest

docker push catchsagar/multi-k8s-client:$SHA
docker push catchsagar/multi-k8s-server:$SHA
docker push catchsagar/multi-k8s-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=catchsagar/multi-k8s-server:$SHA
kubectl set image deployments/client-deployment client=catchsagar/multi-k8s-client:$SHA
kubectl set image deployments/worker-deployment worker=catchsagar/multi-k8s-worker:$SHA
