#!/bin/bash



echo "Stopping ..."
multipass stop mnode
multipass stop wnode1


echo "Deleting ..."
multipass delete mnode
multipass delete wnode1

multipass list 
echo "Purging ... "
multipass purge

echo "List ... "
multipass list 

