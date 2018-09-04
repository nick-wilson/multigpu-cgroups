#!/usr/bin/python
import pbs
import sys
import socket
import subprocess, os

try:
  e=pbs.event()
  j=e.job

  queue=str(j.queue)
  if queue[:2] != "fj" and queue[:3] != "dgx":
    pbs.event().accept()

  command="/usr/local/bin/pbs-dgx-cgroup-create "+str(j.euser)+" "+str(j.id)+" "+str(j.schedselect)+" < /dev/null >> /tmp/hook.log 2>&1"
  os.system(command)

  pbs.event().accept()

except SystemExit:
  pass
except:
  pbs.event().reject("Exception trapped in cgroup create")
