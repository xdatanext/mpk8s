#!/bin/bash

multipass exec mnode -- sudo /snap/bin/microk8s.kubectl label node mnode node-role.kubernetes.io/master=master
multipass exec mnode -- sudo /snap/bin/microk8s.kubectl label node wnode1 node-role.kubernetes.io/worker=worker

multipass exec mnode -- sudo /snap/bin/microk8s.kubectl get no -o wide

multipass exec mnode -- sudo /snap/bin/microk8s.enable rbac dns storage

