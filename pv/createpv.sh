#!/bin/bash


for i in {1..50}
do
  oc create -f - <<EOF
apiVersion: v1
kind: PersistentVolume
metadata:
  labels:
    size: 5Gi
    type: host
  name: pv-$i
spec:
  accessModes:
  - ReadWriteOnce
  - ReadWriteMany
  capacity:
    storage: 5Gi
  nfs: 
    server: 192.168.1.84 
    path: /exports/pv-$i
  persistentVolumeReclaimPolicy: Recycle
EOF

mkdir /exports/pv-$i;
chmod 777 /exports/pv-$i
chown nfsnobody:nfsnobody /exports/pv-$i

echo "/exports/pv-$i *(rw,no_root_squash)" >> /etc/exports;
done

for i in {51..100}
do
  oc create -f - <<EOF
apiVersion: v1
kind: PersistentVolume
metadata:
  labels:
    size: 25Gi
    type: host
  name: pv-$i
spec:
  accessModes:
  - ReadWriteOnce
  - ReadWriteMany
  capacity:
    storage: 25Gi
  nfs:  
    server: 192.168.1.84 
    path: /exports/pv-$i
  persistentVolumeReclaimPolicy: Recycle
EOF

mkdir /exports/pv-$i;
chmod 777 /exports/pv-$i
chown nfsnobody:nfsnobody /exports/pv-$i

echo "/exports/pv-$i *(rw,no_root_squash)" >> /etc/exports;

done


