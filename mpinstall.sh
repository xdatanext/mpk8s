#!/bin/bash

# THis is the directory that gets mounted on each VM
MOUNTDIR=/Users/myuser/mydir

# Launch Ubuntu 18.04 images . mnode is master wnode1 is the first worker node
multipass launch --name mnode 18.04
multipass launch --name wnode1 18.04

# Let's see the release info on the image
multipass exec mnode -- lsb_release -a
multipass exec wnode1 -- lsb_release -a

# Make sure this shows up as Running on multipass list
multipass list

# 
multipass mount $MOUNTDIR mnode:/opt/xdn
multipass mount $MOUNTDIR wnode1:/opt/xdn


multipass list | awk '{ print $3, $1 }' > hosts.mpls

# now update
multipass exec mnode -- sudo apt update
multipass exec mnode -- sudo apt upgrade -y

multipass exec wnode1 -- sudo apt update
multipass exec wnode1 -- sudo apt upgrade -y

multipass exec mnode -- sudo apt install docker.io -y
multipass exec wnode1 -- sudo apt install docker.io -y
