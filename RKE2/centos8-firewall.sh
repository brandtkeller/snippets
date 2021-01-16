firewall-cmd --permanent --zone=trusted --add-interface=flannel.1 && \
firewall-cmd --permanent --zone=trusted --add-source=10.42.0.0/16 && \

## Open up a whole bunch of ports to include 80/443
firewall-cmd --permanent --add-port 9345/tcp && firewall-cmd --permanent --add-port 6443/tcp && \
firewall-cmd --permanent --add-port 8472/udp && firewall-cmd --permanent --add-port 10250/tcp && \
firewall-cmd --permanent --add-port 2379/tcp && firewall-cmd --permanent --add-port 2380/tcp && \
firewall-cmd --permanent --add-port 30000-32767/tcp && firewall-cmd --permanent --add-port 80/tcp && \ 
firewall-cmd --permanent --add-port 443/tcp && firewall-cmd --reload

firewall-cmd --permanent --add-port 53/udp
## edit canal daemonset

kubectl get daemonset rke2-canal -n kube-system -o yaml >> rke2-canal.yaml
sed -i 's/auto/NFT/g' rke2-canal.yaml
kubectl apply -f rke2-canal.yaml

