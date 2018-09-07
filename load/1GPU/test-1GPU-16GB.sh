#!/bin/bash
image="nvcr.io/nvidia/mxnet:18.02-py2"
datadir=/home/projects/41000001/datasets/mxnet480
nvidia-smi
echo tasks in cgroup -- start
cat /sys/fs/cgroup/devices/$PBS_JOBID/tasks
echo tasks in cgroup -- end
nvidia-docker-run $image << EOF
nvidia-smi
echo tasks in cgroup -- start -- $PBS_JOBID
cat /sys/fs/cgroup/devices/$PBS_JOBID/tasks
echo tasks in cgroup -- end -- $PBS_JOBID
echo pid of shell: \$\$
python /opt/mxnet/example/image-classification/train_imagenet.py \
 --gpu 0 \
 --batch-size 110 --num-epochs 1 \
 --data-train $datadir/train_480_100k.rec \
 --data-train-idx $datadir/train_480_100k.idx \
 --disp-batches 10 --network resnet-v1 \
 --num-layers 50
EOF
