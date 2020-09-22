# cdcon2020
cdCon2020 Sample App and Tekton Pipelines


# Dashboard

Run the following command to install Tekton Dashboard and its dependencies on a Kubernetes Cluster:

```shell script
kubectl apply --filename https://storage.googleapis.com/tekton-releases/dashboard/latest/tekton-dashboard-release.yaml
```

By default, the Dashboard is not exposed outside the cluster.

Use `kubectl port-forward` to access the Dashboard UI depending on your setup described below.

Assuming tekton-pipelines is the install namespace for the Dashboard, run the following command:

```shell script
kubectl --namespace tekton-pipelines port-forward svc/tekton-dashboard 9097:9097
```

Browse [http://localhost:9097](http://localhost:9097) to access your Dashboard.


# Knative Serving

The following commands install the Knative Serving component.

Install the Custom Resource Definitions:

```shell script
kubectl apply --filename https://github.com/knative/serving/releases/download/v0.17.0/serving-crds.yaml
```

Install the core components of Serving:

```shell script
kubectl apply --filename https://github.com/knative/serving/releases/download/v0.17.0/serving-core.yaml
```

Installing Istio for Knative:

Download and extract the latest release automatically:

```shell script
curl -L https://istio.io/downloadIstio | sh -
```

Add the istioctl client to your path:

```shell script
export PATH="$PATH:/Users/pdesai/istio-1.7.2/bin"
```

The simplest option is to install the default Istio configuration profile using the following command:

```shell script
istioctl install
```

Check what’s installed:

```shell script
kubectl -n istio-system get deploy
```

Install the Knative Istio controller:

```shell script
kubectl apply --filename https://github.com/knative/net-istio/releases/download/v0.17.0/release.yaml
```

Fetch the External IP or CNAME:

```shell script
kubectl --namespace istio-system get service istio-ingressgateway
```

Monitor the Knative components until all of the components show a STATUS of Running or Completed:

```shell script
kubectl get pods --namespace knative-serving
```