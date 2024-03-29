docker build -t lgxkevin/multi-client:latest -t lgxkevin/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t lgxkevin/multi-server:latest -t lgxkevin/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t lgxkevin/multi-worker:latest -t lgxkevin/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push lgxkevin/multi-client:latest
docker push lgxkevin/multi-server:latest
docker push lgxkevin/multi-worker:latest

docker push lgxkevin/multi-client:$SHA
docker push lgxkevin/multi-server:$SHA
docker push lgxkevin/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=lgxkevin/multi-client:$SHA
kubectl set image deployments/server-deployment server=lgxkevin/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=lgxkevin/multi-worker:$SHA
