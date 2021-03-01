## Flux Notes

* Create github token with all repo permissions

* Run bootstrap (from coder IDE)
```
flux bootstrap github \
  --owner=brandtkeller \
  --repository=flux-personal \
  --path=clusters/home-cluster \
  --kubeconfig /home/coder/development/.kube/config \
  --personal
```

Dislike use of github directly + Would like to understand the Self-Signed internal repo use.
