#!/system/bin/sh
# Copyright (c) 2015, The Linux Foundation. All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#     * Redistributions of source code must retain the above copyright
#       notice, this list of conditions and the following disclaimer.
#     * Redistributions in binary form must reproduce the above copyright
#       notice, this list of conditions and the following disclaimer in the
#       documentation and/or other materials provided with the distribution.
#     * Neither the name of The Linux Foundation nor
#       the names of its contributors may be used to endorse or promote
#       products derived from this software without specific prior written
#       permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NON-INFRINGEMENT ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT OWNER OR
# CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
# EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
# PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
# OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
# WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
# OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
# ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#
if pgrep aplogO_64 > /dev/null 2>&1
then
echo aplogO_64 is running
else
aplogO_64 -y -c mrsekc -f threadtime -a rlmstzifg -p /etc/config.txt &
fi

# This is the file for test teams to trigger their test setup.
#
# Sample command: /system/bin/sh /sdcard/command.sh
# All the output files will be created under root privilege. Please use
# "adb root" before pulling the generated files.
#CustomerMonkey
/system/xbin/su 0 sh /etc/CustomerMonkey.sh &

target=`getprop ro.board.platform`

case "$target" in
    "msm8996")
	echo 1 > /sys/kernel/debug/scm_errata/kryo_e76
	;;
esac
# echo 120 > /proc/sys/vm/watermark_scale_factor	
# echo 0 > /proc/sys/kernel/printk

while [ true ]
do
	sleep 300
	if pgrep aplogO_64 > /dev/null 2>&1
	then
		echo aplogO_64 is running
	else
		aplogO_64 -y -c mrsekc -f threadtime -a rlmstzifg -p /etc/config.txt &
	fi

	if pgrep monkey > /dev/null 2>&1
	then
		echo monkey is running
	else
		pkill -9 -f Cus
		/system/xbin/su 0 sh /etc/CustomerMonkey.sh &
	fi
done	