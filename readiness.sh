#!/bin/sh

DISK_SIZE_THRESHOLD_PCT=90
AVAILABLE_CPUS=$((`nproc` * 2))
CACHE_DIR=/.cache

set -eo pipefail

curl --fail -s http://localhost:8000/health-check
disk_used_pct=`df --output=pcent $CACHE_DIR | tail -1 | sed -E 's;\s+;;g' | tr -d '%'`
if [ $disk_used_pct -gt $DISK_SIZE_THRESHOLD_PCT ]; then
  exit 1
fi

load_avg1=`cat /proc/loadavg | cut -d' '-f 1`
if [ $load_avg -gt $AVAILABLE_CPUS ]; then
  exit 1
fi

exit 0
