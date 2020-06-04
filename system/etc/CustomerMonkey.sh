#!/system/bin/sh
setprop service.adb.root 1
sleep 30
mkdir /sdcard/MonkeyLog
sleep 30

while [ true ]
do
	pgrep monkey|xargs kill -9
	sleep 10
	timeStamp=`date +"%m-%d-%Y_%H-%M-%S"`
	num=$(($RANDOM%10))
	echo $num
	case ${num} in 
		[0-3])
			throttle=500
			;;
		[4-6])
			throttle=300
			;;
		[7-9])
			throttle=100
			;;
	esac
	starttime=`date +"%m-%d-%Y_%H-%M-%S"`
	echo $starttime >> /sdcard/MonkeyLog/time.log
	sleep 2
	settings put global airplane_mode_on 0
	sleep 2
	input keyevent 82
	sleep 2
	svc wifi enable
	sleep 2
	monkey -s 254 --throttle $throttle --ignore-timeouts --ignore-crashes --ignore-security-exceptions --kill-process-after-error --pct-trackball 0 --pct-syskeys 0 --pkg-blacklist-file /sdcard/Monkey/blacklist.txt 100000 >> /sdcard/MonkeyLog/$timeStamp.log
	sleep 2
	echo $throttle >> /sdcard/MonkeyLog/time.log
	sleep 2
	endtime=`date +"%m-%d-%Y_%H-%M-%S"`
	echo $endtime >> /sdcard/MonkeyLog/time.log
	sleep 2
done
