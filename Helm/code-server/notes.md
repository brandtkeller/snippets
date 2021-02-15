# Code Server Deployment

`helm install code --values ./Helm/code-server/coder-values --set serviceAccount.name=coder --set ingress.enabled=true --set password=mypassword ../Code-Server-Helm/ -n cicd`

