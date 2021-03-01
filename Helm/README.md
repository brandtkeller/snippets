# Helm Deployments as Code
The purpose of this directory is for historical tracking of orchestration across many applications.

By Source Controlling the values.yaml files and any other accompanying modification, I can establish a mirrored architecture of the deployment.

## Self Signed Cert Trust
Much of the orchestration will involve varying methods for each application to trust a Self Signed Root CA.
These Provide examples for how to accomplish this logic. Some involve modiications to internal files. Others allow more abstract improvising via the helm chart and values in order to orchestrate the logic. 

## Configurations
Other modifications and configurations are orchestrated and this directory provides tracking for implementation purposes.

## Passwords
Passwords are reset to their defaults or REDACTED for custom configurations for storage IN SCM.