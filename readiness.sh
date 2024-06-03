#!/bin/bash

set -eo pipefail

DISK_SIZE_THRESHOLD_PCT=85
LOAD_AVG_THRESHOLD=$((`nproc`*10))
CACHE_DIR=/.cache

curl --fail -s http://localhost:8000/health-check
disk_used_pct=`df --output=pcent $CACHE_DIR | tail -1 | sed -E 's;\s+;;g' | tr -d '%'`
if [ $disk_used_pct -gt $DISK_SIZE_THRESHOLD_PCT ]; then
  exit 1
fi

load_avg1=`cat /proc/loadavg | cut -d' ' -f 1`
if (($(echo "${load_avg1} > ${LOAD_AVG_THRESHOLD}" | bc -l))); then
  exit 1
fi

exit 0
