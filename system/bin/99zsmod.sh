#!/system/bin/sh
  ################################
 #  ZsMod Service Notes  #
################################

line=================================================;
echo "";
echo $line;
echo "   The ZsMod=- by -=huangzs=-";
echo $line;
echo "";
id=`id`; id=`echo ${id#*=}`; id=`echo ${id%%\(*}`; id=`echo ${id%% *}`;
if [ "$id" != "0" ] && [ "$id" != "root" ]; then
	echo " You are NOT running this script as root...";
	echo "";
	echo $line;
	echo "                      ...No SuperUser for you!!";
	echo $line;
	echo "";
	echo "     ...Please Run as Root and try again...";
	echo "";
	echo $line;
	echo "";
	exit 69;
fi;
echo " To verify application of settings...";
echo "";
echo "       ...check out /data/Ran_ZsMod.log!";
echo "";
echo $line;
echo "";


		echo " Waiting 90 seconds (avoid conflicts)... then...";echo "";
		echo " Gonna ZsMod this Android... zoOM... zOOM!";
		echo "";
		echo $line;
		echo "";
		sleep 90;


if [ "`cat /proc/sys/vm/min_free_kbytes`" -ne 5120 ] || [ "`cat /proc/sys/net/core/rmem_max`" -ne 1048576 ] || [ "`cat /sys/block/mmcblk0/bdi/read_ahead_kb`" -ne 1024 ]; then
	  ####################################
	 #  Kernel & Virtual Memory Tweaks  #
	####################################
	busybox sysctl -w vm.min_free_kbytes=5120;
	busybox sysctl -w vm.oom_kill_allocating_task=0;
	busybox sysctl -w vm.panic_on_oom=0;
	busybox sysctl -w vm.overcommit_memory=1;
	busybox sysctl -w vm.swappiness=20;
	busybox sysctl -w kernel.panic_on_oops=1;
	busybox sysctl -w kernel.panic=30;

	  #########################
	 #  SD Read Speed Tweak  #
	#########################
	if [ "`ls /sys/devices/virtual/bdi/179*/read_ahead_kb`" ]; then
		for i in `ls /sys/devices/virtual/bdi/179*/read_ahead_kb`; do echo 1024 > $i; done;
	fi 2>/dev/null;
	echo 1024 > /sys/block/mmcblk0/bdi/read_ahead_kb 2>/dev/null;
	echo 1024 > /sys/block/mmcblk0/queue/read_ahead_kb 2>/dev/null;
	echo "";
	echo $line;
	echo "";
fi;
currentadj=`cat /sys/module/lowmemorykiller/parameters/adj` 2>/dev/null;
currentminfree=`cat /sys/module/lowmemorykiller/parameters/minfree` 2>/dev/null;
scadj="0,3,6,10,12,15";
scminfree="2048,3072,6400,6912,7680,8192";
if [ "$scminfree" ] && [ "$currentminfree" != "$scminfree" ]; then applyscminfree=yes; fi;
if [ "$scadj" ] && [ "$currentadj" != "$scadj" ]; then applyscadj=yes; fi;
if [ "$applyscminfree" ] || [ "$applyscadj" ]; then

	chmod 777 /sys/module/lowmemorykiller/parameters/adj 2>/dev/null;
	chmod 777 /sys/module/lowmemorykiller/parameters/minfree 2>/dev/null;
	if [ "$scadj" ]; then echo $scadj > /sys/module/lowmemorykiller/parameters/adj; fi 2>/dev/null;
	if [ "$scminfree" ]; then echo $scminfree > /sys/module/lowmemorykiller/parameters/minfree; fi 2>/dev/null;
	echo " $( date +"%m-%d-%Y %H:%M:%S" ): Applied settings from $0!" >> /data/Ran_ZsMod.log;
	echo "         ZsMod Settings Applied!";
elif [ "`pgrep -l android`" ]; then
	echo " $( date +"%m-%d-%Y %H:%M:%S" ): No need to reapply settings from $0!" >> /data/Ran_ZsMod.log;
	echo " ZsMod Settings Were ALREADY Applied...";
	echo "";
	echo "            ...there is no need to reapply them!";
fi;
echo "";
echo " $0 Executed...";
echo "";
echo "          ===========================";
echo "           ) ZsMod Complete! (";
echo "          ===========================";


exit 0;

