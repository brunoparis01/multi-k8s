docker build -t brunoparis/multi-client:latest -t brunoparis/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t brunoparis/multi-server:latest -t brunoparis/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t brunoparis/multi-worker:latest -t brunoparis/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push brunoparis/multi-client:latest
docker push brunoparis/multi-server:latest
docker push brunoparis/multi-worker:latest

docker push brunoparis/multi-client:$SHA
docker push brunoparis/multi-server:$SHA
docker push brunoparis/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=brunoparis/multi-server:$SHA
kubectl set image deployments/client-deployment client=brunoparis/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=brunoparis/multi-worker:$SHA
