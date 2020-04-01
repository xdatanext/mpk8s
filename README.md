# mpk8s
Multipass Kubernetes setup for a simple 2 node cluster 

## Install two images . One for Master and one for Worker using multipass

Before this script is executed, edit the MOUNTDIR to point to the directory that needs
to be mounted

```bash
	% ./mpinstall.sh

```

Now let's check to make sure that the VMs are running 
```bash
	% multipass list
	Name                    State             IPv4             Image
	mnode                   Running           192.168.64.7     Ubuntu 18.04 LTS
	wnode1                  Running           192.168.64.9     Ubuntu 18.04 LTSa
```

Once the installation is complete it will create a file `hosts.mpls`
with IPv4 and hostname entries for all the mosts created by multipass

Please use `multipass transfer` command to transfer these files to each unit 
and append on each hosts /etc/hosts file. 

or you can use `multipass shell` into each VM and append the hosts.mpls file 

## Now let's install microk8s Kubernetes distro on each unit

```bash
	% ./kinstall.sh
```
Now let's make sure we can do a simple kubectl command on the master 

```bash
	% multipass exec mnode -- sudo /snap/bin/kubectl get no
	NAME     STATUS   ROLES    AGE    VERSION
	mnode    Ready    master   2d5h   v1.18.0
```

Now we want to make sure that the worker node joins the cluster

```bash
	% ./kmjoin.sh
```
This will print a join command that needs to run on the worker node

```bash
	% microk8s join 192.168.64.7:25000/HNfCnPyUHamYteGNIrDobhJiGiRlPaeQ
```
Now check to make sure that the Cluster  labelled and it is up

```bash
	% ./klabel.sh
	% multipass exec mnode -- sudo /snap/bin/kubectl get no
	NAME     STATUS   ROLES    AGE    VERSION
	mnode    Ready    master   2d6h   v1.18.0
	wnode1   Ready    worker   2d5h   v1.18.0
```

Now Let's load the mysql container on a PVC Claim created on a local directory 
Edit the variable hostPath in the file mysql-pv.yaml to point to the directory that 
the mysql instance will use as a Voume for the database 

Now crete the PV first for mysql  on mnode
```bash
	% kubectl apply -f mysql-pv.yaml
```

Now we kick off the MySQL instance container on this PV no mnode

```bash
	% kubectl apply -f mysql-deployment.yaml
```

Check to see that the deployment is there  on mnode

```bash
	% kubectl get deployments
```

While we are at it , let's crete a simple nginx deployment instance

```bash
	% ./knginx.sh
```

Check the deployments again and see that both are running 


```bash
	% kubectl get deployments
```



