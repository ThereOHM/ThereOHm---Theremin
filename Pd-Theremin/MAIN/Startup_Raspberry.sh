#!/bin/bash
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# 		ThereOHM - Startup-Script
#
# Purpose: 
#	- Configuration
# 	- Play User Audio-Information-Text
#	- Launch pd
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++

#Path declaration
PATH_PD_WORKSPACE="/home/pi/PD-Workspace/MAIN/"
PATH_PD_LIB="/home/pi/PD-Workspace/Libraries"

echo "+++++++++++++++++++++++++++"
echo "      ThereOHM             "
echo "      	                 "
echo "  Configuration & Startup	 "
echo "          	         "
echo "+++++++++++++++++++++++++++"
echo "          	         "

##********************************************
echo "          	         "
echo " - Stop unneeded Services	 "

## Stop the ntp service
sudo service ntp stop

## Stop the triggerhappy service
sudo service triggerhappy stop

## Stop the dbus service. Warning: this can cause unpredictable behaviour when running a desktop environment on the RPi
#sudo service dbus stop

## Stop the console-kit-daemon service. Warning: this can cause unpredictable behaviour when running a desktop environment on the RPi
#sudo killall console-kit-daemon

## Stop the polkitd service. Warning: this can cause unpredictable behaviour when running a desktop environment on the RPi
#sudo killall polkitd

## Only needed when Jack2 is compiled with D-Bus support (Jack2 in the AutoStatic RPi audio repo is compiled without D-Bus support)
#export DBUS_SESSION_BUS_ADDRESS=unix:path=/run/dbus/system_bus_socket

## Remount /dev/shm to prevent memory allocation errors
sudo mount -o remount,size=128M /dev/shm

## Kill the usespace gnome virtual filesystem daemon. Warning: this can cause unpredictable behaviour when running a desktop environment on the RPi
#killall gvfsd

## Kill the userspace D-Bus daemon. Warning: this can cause unpredictable behaviour when running a desktop environment on the RPi
#killall dbus-daemon

## Kill the userspace dbus-launch daemon. Warning: this can cause unpredictable behaviour when running a desktop environment on the RPi
#killall dbus-launch

## Uncomment if you'd like to disable the network adapter completely
#echo -n “1-1.1:1.0” | sudo tee /sys/bus/usb/drivers/smsc95xx/unbind

## Set the CPU scaling governor to performance
echo -n performance | sudo tee /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor

## And finally start JACK
#jackd -P70 -p16 -t2000 -d alsa -dhw:UA25 -p 128 -n 3 -r 44100 -s &

##********************************************

#echo "          	         "
#echo " - Check Internet Connection	 "
 
#wget -q --tries=10 --timeout=20 --spider http://google.com
#wget -q --tries=10 --timeout=20 -O - http://google.com > /dev/null
#if [[ $? -eq 0 ]]; then
#        echo "Internet Connection Available..."

# Variable Startup Sound
#./Software/Text_to_Speech/Speech_longtext.sh Hello Mr Kleen, lets start playing!

#else
#        echo "No Internet Connection Available --> Online Features like streaming will not work!"

# Play Startup Sound
#mpg123 -a hw:1 ./Software/Text_to_Speech/de.mp3
#fi



# echto "Starting Pd..."
cd $PATH_PD_WORKSPACE
#sudo pd-extended -lib wiringPi_gpio -path $PATH_PD_LIB
#cpulimit -e pd-extended -l 50 -z

sudo pd -lib wiringPi_gpio -path $PATH_PD_LIB

# pd ohne GUI starten: pd-extended -nogui -jack oder -alsa -open patch.pd 




