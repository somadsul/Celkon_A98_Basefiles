#!/system/bin/sh
if [ ! -e /data/swp ]; then	
  /system/xbin/busybox swapoff /dev/block/loop7;
  /system/xbin/busybox dd if=/dev/zero of=/data/swp bs=1024 count=180000;
fi
 /system/xbin/busybox losetup /dev/block/loop7 /data/swp;
 /system/xbin/busybox mkswap /dev/block/loop7;
 /system/xbin/busybox swapon /dev/block/loop7;	
