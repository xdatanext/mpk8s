#!/bin/bash

# Install microk8s Kubernetes distribution from Canonical
multipass exec mnode -- sudo snap install microk8s --classic --channel=1.18
multipass exec mnode -- sudo snap alias microk8s.kubectl kubectl
multipass exec mnode -- sudo microk8s.status --wait-ready


multipass exec wnode1 -- sudo snap install microk8s --classic --channel=1.18
multipass exec wnode1 -- sudo snap alias microk8s.kubectl kubectl
multipass exec wnode1 -- sudo microk8s.status --wait-ready


