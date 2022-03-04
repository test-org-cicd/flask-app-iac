# Flask App IAC

This is a repo contains infrastructure as code for the [Flask App Project](https://github.com/test-org-cicd/flask-app-project).

0. Clone the git repository and enter into the folder
```
git clone https://github.com/test-org-cicd/flask-app-iac.git
cd flask-app-iac
```

1. CREATE THE AWS EKS CLUSTER
```
cd terraform-eks
terraform init
terraform plan -out eks-demo
terraform apply "eks-demo"
cd ..
```

2. CREATE THE K8s OBJECT FOR JENKINS DEPLOYMENT
```
cd terraform-k8s
terraform init
terraform plan -out k8s-cicd
terraform apply "k8s-cicd"
cd ..
```

3. DEPLOY JENKINS
```
kubectl apply -f ./kubernetes/jenkins
```

## LICENSE

The Flask Application is GNU GPL3 licensed. See the LICENSE file for details.
