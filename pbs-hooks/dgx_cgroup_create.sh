#!/bin/bash
cd `dirname $0`

qmgr << EOF
create hook dgx_cgroup_create
set hook dgx_cgroup_create type = site
set hook dgx_cgroup_create enabled = true
set hook dgx_cgroup_create event = execjob_launch
set hook dgx_cgroup_create user = pbsadmin
set hook dgx_cgroup_create alarm = 600
set hook dgx_cgroup_create order = 100
set hook dgx_cgroup_create debug = false
set hook dgx_cgroup_create fail_action = none
import hook dgx_cgroup_create application/x-python default $PWD/dgx_cgroup_create.py
EOF

qmgr -c "print hook dgx_cgroup_create" | tee dgx_cgroup_create.in
