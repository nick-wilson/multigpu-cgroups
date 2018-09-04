#!/bin/bash
cd `dirname $0`

qmgr << EOF
create hook dgx_cleanup
set hook dgx_cleanup type = site
set hook dgx_cleanup enabled = true
set hook dgx_cleanup event = execjob_epilogue
set hook dgx_cleanup user = pbsadmin
set hook dgx_cleanup alarm = 600
set hook dgx_cleanup order = 1
set hook dgx_cleanup debug = false
set hook dgx_cleanup fail_action = none
import hook dgx_cleanup application/x-python default $PWD/dgx_cleanup.py
EOF

qmgr -c "print hook dgx_cleanup" > dgx_cleanup.in
