#!/bin/bash
set -x #echo on

# bootloader partitions
sgdisk     -n1:1M:+512M   -t1:EF00 $DISK0
sgdisk     -n1:1M:+512M   -t1:EF00 $DISK1

# swap partitions:
sgdisk     -n2:0:+500M    -t2:FD00 $DISK0
sgdisk     -n2:0:+500M    -t2:FD00 $DISK1

# boot pool partitions:
sgdisk     -n3:0:+2G      -t3:BE00 $DISK0
sgdisk     -n3:0:+2G      -t3:BE00 $DISK1

# root pool partitions:
sgdisk     -n4:0:0        -t4:BF00 $DISK0
sgdisk     -n4:0:0        -t4:BF00 $DISK1
