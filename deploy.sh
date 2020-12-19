docker build -t oyashi163/multi-client:latest -t oyashi163/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t oyashi163/multi-server:latest -t oyashi163/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t oyashi163/multi-worker:latest -t oyashi163/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push oyashi163/multi-client:latest
docker push oyashi163/multi-server:latest
docker push oyashi163/multi-worker:latest

docker push oyashi163/multi-client:$SHA
docker push oyashi163/multi-server:$SHA
docker push oyashi163/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deloyments/server-deployment server=oyashi163/multi-server:$SHA
kubectl set image deloyments/client-deployment client=oyashi163/multi-client:$SHA
kubectl set image deloyments/worker-deployment worker=oyashi163/multi-worker:$SHA
