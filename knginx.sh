#!/bin/bash

multipass exec mnode -- sudo /snap/bin/kubectl create deployment nginx --image=nginx
