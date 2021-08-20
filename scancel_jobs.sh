#!/bin/bash

#######################
# 'bash cancel-jobs.sh 50000' to cancel all your jobs with job ids greater than 50,000.
# If you want it to cancel job numbers greater than or equal to the minimum job number, change the -gt to -ge
#########################

declare -a jobs=()

if [ -z "$1" ] ; then
    echo "Minimum Job Number argument is required.  Run as '$0 jobnum'"
    exit 1
fi

minjobnum="$1"

myself="$(id -u -n)"

for j in $(squeue --user="$myself" --noheader --format='%i') ; do
  if [ "$j" -gt "$minjobnum" ] ; then
    jobs+=($j)
  fi
done

scancel "${jobs[@]}"
