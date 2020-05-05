#!/bin/bash
# store free memory in file
echo -e "This file list the amount of free memory \n" > ~/Documents/week5/hw5/backups/freemem/free_mem.txt
free -h >> ~/Documents/week5/hw5/backups/freemem/free_mem.txt

# store disk usage in file
echo -e "This file list the amount of disk usage \n" > ~/Documents/week5/hw5/backups/diskuse/disk_usage.txt
df -H | head -1  >> ~/Documents/week5/hw5/backups/diskuse/disk_usage.txt
df -H | grep /dev/sda1 >> ~/Documents/week5/hw5/backups/diskuse/disk_usage.txt

# stores list of open files
echo -e "This file list all the open files \n" > ~/Documents/week5/hw5/backups/openlist/openlist.txt
sudo lsof >> ~/Documents/week5/hw5/backups/openlist/openlist.txt

# file system disk space stats
echo -e "This file list the files system disk space statistics \n" > ~/Documents/week5/hw5/backups/freedisk/freedisk.txt
du -h >> ~/Documents/week5/hw5/backups/freedisk/freedisk.txt

