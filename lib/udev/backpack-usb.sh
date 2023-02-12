#!/bin/sh

# Load bulk/interrupt transfer test firmware into
# various EZ-USB USB devices that will run it

#TEMPLATE PROGRAM TAKEN FROM http://linux-hotplug.sourceforge.net/perf 4/2/2002
#Adapted for BACKPACK USB drives 

FIRMWARE=
FLAGS=

# pre-renumeration device IDs
case $PRODUCT in

# BACKPACK USB2 INTERNAL ADAPTER

#----------------------SCANNNERS SCANNERS-------------------------------
#external usb1 scanner
ac9/0/0)
	FIRMWARE=/lib/firmware/backpack-usb.d/BP1SCAN.HEX
	;;

#external usb2 scanner
ac9/1/*)
	FIRMWARE=/lib/firmware/backpack-usb.d/BP2SCAN.HEX
	FLAGS="-2"
	;;

#----------------------USB1 EXTERNAL-------------------------------
#external usb1 cd-romish series 5
ac9/1000/*)
	FIRMWARE=/lib/firmware/backpack-usb.d/BP1CD5.HEX
	;;
#external usb1 cd-romish series 6
ac9/1001/*)
	FIRMWARE=/lib/firmware/backpack-usb.d/BP1CD6.HEX
	;;
#external usb1 hard drive series 5
ac9/1002/*)
	FIRMWARE=/lib/firmware/backpack-usb.d/BP1HD5.HEX
	;;
#external usb1 hard drive series 6
ac9/1003/*)
	FIRMWARE=/lib/firmware/backpack-usb.d/BP1HD6.HEX
	;;

#----------------------USB2 EXTERNAL-------------------------------
#external usb2 cd-romish series 5
ac9/1004/*)
	FIRMWARE=/lib/firmware/backpack-usb.d/BP2CD5.HEX
	FLAGS="-2"
	;;
#external usb2 cd-romish series 6
ac9/1005/*)
	FIRMWARE=/lib/firmware/backpack-usb.d/BP2CD6.HEX
	FLAGS="-2"
	;;
#external usb2 hard drive series 5
ac9/1006/*)
	FIRMWARE=/lib/firmware/backpack-usb.d/BP2HD5.HEX
	FLAGS="-2"
	;;
#external usb2 hard drive series 6
ac9/1007/*)
	FIRMWARE=/lib/firmware/backpack-usb.d/BP2HD6.HEX
	FLAGS="-2"
	;;

#----------------------USB2 INTERNAL-------------------------------
#internal usb2 cd-romish drive
ac9/10/*)
	FIRMWARE=/lib/firmware/backpack-usb.d/BPINTCD.HEX
	FLAGS="-2"
	;;

#internal usb2 cd-romish drive
ac9/11/*)
	FIRMWARE=/lib/firmware/backpack-usb.d/BPINTHD.HEX
	FLAGS="-2"
	;;
esac


# quit unless we were called to download some firmware 
if [ "$FIRMWARE" = "" ]; then
    # OR:  restructure to do other things for
    # specific post-renumeration devices
    exit 0
fi

# missing firmware?
if [ ! -r $FIRMWARE ]; then
    if [ -x /usr/bin/logger ]; then
	/usr/bin/logger -t $0 "missing $FIRMWARE for $PRODUCT ??"
    fi
    exit 1
fi

if [ ! -x /sbin/fxload ]; then
	if [ -x /usr/bin/logger ]; then
		/usr/bin/logger -t $0 "cannot load firmware, missing fxload"
    	fi
    	exit 1
fi 

if [ -x /usr/bin/logger ]; then
    /usr/bin/logger -t $0 "load $FIRMWARE for $PRODUCT to $DEVICE"
fi

	/sbin/fxload $FLAGS -I $FIRMWARE
   
