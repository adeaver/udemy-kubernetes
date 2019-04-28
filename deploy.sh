docker build -t adeaver/udemy-multi-client:latest -t adeaver/udemy-multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t adeaver/udemy-multi-server:latest -t adeaver/udemy-multi-server:$SHA  -f ./server/Dockerfile ./server
docker build -t adeaver/udemy-multi-worker:latest -t adeaver/udemy-multi-worker:$SHA  -f ./worker/Dockerfile ./worker

docker push adeaver/udemy-multi-client:latest
docker push adeaver/udemy-multi-server:latest
docker push adeaver/udemy-multi-worker:latest

docker push adeaver/udemy-multi-client:$SHA
docker push adeaver/udemy-multi-server:$SHA
docker push adeaver/udemy-multi-worker:$SHA

kubectl apply -f ./k8s-config
kubectl set image deployments/server-deployment server=adeaver/udemy-multi-server:$SHA
kubectl set image deployments/client-deployment client=adeaver/udemy-multi-client:$SHA
kubectl set image deployments/worker-deployment worker=adeaver/udemy-multi-worker:$SHA
