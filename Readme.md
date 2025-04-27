🚀 README: Setting up Milvus and Deploying a Test Go App on Minikube
This guide walks you through:

Starting a local Kubernetes cluster

Deploying Milvus using Helm

Building your custom Go test application

Running everything on your Minikube setup


**1. Start Minikube Cluster

minikube start --memory=8g --cpus=4

✅ Explanation:
This starts a local Kubernetes cluster with: 8 GB of memory 4 CPU cores We allocate enough resources because Milvus is memory-intensive.

**2. Install Helm (if not installed)

```bash
curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash
```

✅ Explanation:
Helm is a package manager for Kubernetes — like apt or yum for clusters.
This script downloads and installs Helm 3, which we will use to deploy Milvus easily.

**3. Add the Milvus Helm Repository

```bash
helm repo add milvus https://milvus-io.github.io/milvus-helm/
```

✅ Explanation:
This command adds the official Milvus Helm charts repository to your local Helm setup, so you can install Milvus by name.

**4. Update Helm Repositories

```bash
helm repo update
```

✅ Explanation:
Downloads the latest version of all Helm charts (including Milvus) so we get the newest Milvus version when installing.


**5. Install Milvus (Standalone Mode)

```bash
helm install milvus-standalone milvus/milvus --set cluster.enabled=false
```

✅ Explanation:
Deploys a standalone version of Milvus (not a distributed cluster) on your Minikube Kubernetes cluster.
milvus-standalone → name for your deployment
cluster.enabled=false → we run only one instance, easier for local dev and tests.
⌛ This will create Kubernetes Pods for Milvus services (etcd, minio, Milvus standalone).


**6. Build Your Go Test Application
```bash
docker build -t milvus-test-app:latest .
```

✅ Explanation:
This command builds your Go application Docker image locally and tags it as milvus-test-app:latest.

**7. Load the Docker Image into Minikube

```bash
minikube image load milvus-test-app:latest
```

✅ Explanation:
Since Minikube runs its own Docker environment, we need to load our local image into Minikube's Docker daemon so it can use it inside Pods.

**8. Deploy Your Go Application to Kubernetes

```bash
kubectl apply -f deployment.yaml
```

✅ Explanation:
This command deploys your Go application to the Kubernetes cluster using a Deployment configuration specified in your deployment.yaml file.
It schedules a Pod running your app.
The app can then connect to the Milvus service deployed earlier.

