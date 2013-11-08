#!/tmp/busybox sh

HW=$(/tmp/busybox cat /proc/cpuinfo | /tmp/busybox grep Hardware | /tmp/busybox sed s/Hardware// | /tmp/busybox tr '[A-Z]' '[a-z]' | /tmp/busybox tr -d ' ' | /tmp/busybox tr -d ':' | /tmp/busybox tr -d '\t')
DEVICE=$(/tmp/busybox cat /default.prop | /tmp/busybox grep ro.cm.device | /tmp/busybox sed s#ro\.cm\.device=## | /tmp/busybox tr '[A-Z]' '[a-z]')

case $HW in
p1|gt-p1000)
	model=p1
;;
p1l|gt-p1000l|p1n|gt-p1000n|p1ln)
	model=p1ln
;;
*)
echo "Invalid model: $HW"
exit 2
;;
esac

if [ "$model" == "p1" ] ; then
case $DEVICE in
p1)
;;
p1l|p1n)
	model=p1ln
;;
*)
	echo "Invalid device: $DEVICE"
;;
esac
fi

if [ "$model" != "p1" ] ; then
/tmp/busybox rm /tmp/boot.img
/tmp/busybox mv /tmp/boot_$model.img /tmp/boot.img
fi

exit 0
