# Gitea Deployment
`helm upgrade --install git --values git-values.yaml gitea-charts/gitea -n cicd`

## Helm Chart

### Trusting Self Signed Certificates
* Mount root ca cert into the pod/container

* Create a custom ConfigMap to overwrite the default entrypoint
    * Add in an invocation for `update-ca-certificates`
    * Deploy configmap
    * Mount configmap as a volume
        * use subpath
        * set proper execution permissions
