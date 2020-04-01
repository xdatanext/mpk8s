#!/bin/bash

cmd=$(multipass exec mnode -- sudo /snap/bin/microk8s.add-node | grep Join | awk -Fwith: '{ print $2 }')
echo $cmd

echo "Please run "
echo "multipass exec wnode1 -- sudo /snap/bin/$cmd"

multipass exec mnode -- sudo /snap/bin/microk8s.kubectl get no

