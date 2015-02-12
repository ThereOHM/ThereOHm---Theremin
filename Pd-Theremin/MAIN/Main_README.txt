  _____ _                    ___  _   _ __  __ 
 |_   _| |__   ___ _ __ ___ / _ \| | | |  \/  |
   | | | '_ \ / _ \ '__/ _ \ | | | |_| | |\/| |
   | | | | | |  __/ | |  __/ |_| |  _  | |  | |
   |_| |_| |_|\___|_|  \___|\___/|_| |_|_|  |_| 2015

 Project Work in the "Master of Electronic- & Mechatronic Systems Engineering" course

 Created by: 	Fiedler, Herberg, Igel
 Contact: 	ThereOHM@alpenjodel.de

--------------------------------------------------------------------------------------------------


If you want to execute the ThereOHM Pd-Patch, please assure, that the
following conditions complie to your system configuration.
Otherwise the Patch will not work properly.


1. x86- vs. x64- vs. ARM-Processor Architecture

   The Patch uses STK-Libraries, that are currently not native supported for all operating systems.
   If youre using a x86 (32Bit) Windows or Linux architecture or an Raspberry Pi youre fine.
   All libaries are precompiled attached. 
   If youre using a x64 (64Bit) system architecture you have compile the libaries on your own.
   Be aware that this could take some time ;-)



2. Windows Operating System

   If your using a Windows operating system please download Pd-extended following the instructions
   on the webpage: http://puredata.info/downloads/pd-extended



3. Linux Operating System


   If your using a Linux operating system please install the following packages to assure, that Pure Data
   works properly.

   	- Installation of Pd-extended via thrid party repository:
			$ sudo add-apt-repository "deb http://apt.puredata.info/releases `lsb_release -c | awk '{print $2}'` main"
 
			$ sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-key 9f0fe587374bbe81
 sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-key D63D3D09C39F5EEB
 
			$ sudo apt-get update
 
			$ sudo apt-get install pd-extended

	- Installation of further packages:
			$ sudo apt-get install g++
			
$ sudo apt-get install csound		//otherwise STK will throw an error "libstk.so.0: cannot open shared object file: No such file or directory"
			$ sudo apt-get install libasound2-dev	//otherwise STK will throw an error corresponding, that it can't configure
	

   Some of the STK-Libraries need special raw audio files. These files are automatically installed if you are using a new operating system and new Pd-extended version.
   But ff your running not the latest versions please check preventively if there are rawfiles located in the folder /usr/share/stk/rawwaves
   If you don't have a /usr/share/stk directory, you'll need to create it: 
   
			$ sudo mkdir /usr/share/stk
   

Download the binaries raws corresponding to your operating system on the CCRMA-Website, or find them attached to the ThereOHm files for x86 architecture:
	https://ccrma.stanford.edu/wiki/Stk2pd
	https://ccrma.stanford.edu/wiki/Stk2pd444
   After downloading and uncompressing the externs, navigate to the directory and copy the rawwaves to /usr/share/stk by typing from the terminal:
			$ sudo cp -r rawwaves /usr/share/stk/rawwaves
			

   Now all you need is installed on your system. 
   To launch the Patch, you just need to give the _linux Files in the folder read an write access privileges.
   Or to save typing effort give all files full access 
			$ sudo chmod -R 777 ./MAIN


4. Raspberry Platform

   If your using a Raspberry Pi please follow the steps mentioned under 3. 
   In addition to this you should start Pd always in sudo mode. Otherwise Pd would not work properly.
   
   In addition to this, you could use the following Bash-Script for startup.
	
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

## Stop the console-kit-daemon service. Warning: this can cause un   predictable behaviour when running a desktop environment on the RPi
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
#killall dbus-launc   h

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
cd $PATH_PD_WO   RKSPACE
#sudo pd-extended -lib wiringPi_gpio -path $PATH_PD_LIB
#cpulimit -e pd-extended -l 50 -z

sudo pd -lib wiringPi_gpio -path $PATH_PD_LIB

# pd ohne GUI starten: pd-extended -nogui -jack oder -alsa -open patch.pd 

			

                                               