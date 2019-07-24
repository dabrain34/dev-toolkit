Our approach to setup a TFTP server is quite similar to other guides that you can find via Google.
Here we provide some instructions for reference:
Setup TFTP

Install TFTP packages:

$ sudo apt-get install openbsd-inetd tftpd tftp

Configuration

To enable the TFTP server, edit the file /etc/inetd.conf as the root user, and locate the line that looks like the following:

#tftp   dgram   udp     wait    root    /usr/sbin/tcpd  /usr/sbin/in.tftpd

Uncomment this line, and add the option and value -s /srv/tftp to the end of this line:

tftp   dgram   udp   wait   root   /usr/sbin/tcpd  /usr/sbin/in.tftpd -s /srv/tftp

Create and modify permissions on the TFTP root directory:

$ sudo mkdir /srv/tftp
$ sudo chown -R $(whoami) /srv/tftp

Restart the TFTP Service:

$ sudo /etc/init.d/xinetd restart

Setup For Target Device

To setup TFTP on your target device, you will need to:

    Connect a LAN cable to your target device, and make sure your device is on same local network with your Host PC.
    Connect a “Serial-To-USB Module” between the target device and Host PC and ensure you have done the correct setup.
    Power-on your target device, and ensure the device has a Bootloader installed in it.

Stop U-Boot autoboot by hitting Enter or Space key at the moment you power on your target device:

U-Boot 2015.01 (May 18 2019 - 19:31:53)

DRAM:  3.8 GiB
Relocation Offset is: d6e56000

...

gpio: pin GPIOAO_7 (gpio 7) value is 1
Hit Enter or space or Ctrl+C key to stop autoboot -- :  0 
kvim3#

Setup the ip address of the target client and TFTP host server:

kvim3# setenv ipaddr 192.168.1.249
kvim3# setenv serverip 192.168.1.117

Save the settings:

kvim3# saveenv
Saving Environment to aml-storage...
mmc env offset: 0x6c00000 
Writing to MMC(1)... done
kvim3#

Running saveenv will save the env values to the env partition on the eMMC. You can run defenv to restore the env to the default values.

NOTE:How to confirm that your configuration is correct.

kvim3#print ipaddr
ipaddr=192.168.1.249
kvim3#print serverip
serverip=192.168.1.117

Test Your TFTP Server

Make sure you have copied the testing file to the TFTF root path:

$ ls /srv/tftp/u-boot.bin
/srv/tftp/u-boot.bin
$

Load a file into the 0x1080000 address:

kvim3# tftp 1080000 u-boot.bin
Speed: 1000, full duplex
Using dwmac.ff3f0000 device
TFTP from server 192.168.1.117; our IP address is 192.168.1.249
Filename 'u-boot.bin'.
Load address: 0x1080000
Loading: #################################################################
	 #################################################################
	 ###############################################
	 2.5 MiB/s
done
Bytes transferred = 1371504 (14ed70 hex)
