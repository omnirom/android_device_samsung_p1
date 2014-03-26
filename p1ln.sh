#!/tmp/busybox sh
#
# Copyright (C) 2012 The CyanogenMod Project
# Copyright (C) 2013 OmniROM Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

HW=$(busybox cat /proc/cpuinfo | \
    busybox grep Hardware | \
    busybox sed s/Hardware// | \
    busybox tr '[A-Z]' '[a-z]' | \
    busybox tr -d ' ' | \
    busybox tr -d ':' | \
    busybox tr -d '\t')

DEVICE=$(busybox cat /default.prop | \
    busybox grep ro.omni.device | \
    busybox sed s#ro\.omni\.device=## | \
    busybox tr '[A-Z]' '[a-z]')

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
    busybox rm /tmp/boot.img
    busybox mv /tmp/boot_$model.img /tmp/boot.img
fi

exit 0
