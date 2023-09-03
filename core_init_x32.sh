#!/bin/bash

# Update and upgrade the Raspberry Pi
sudo apt-get update 
sudo apt-get upgrade -y

# Install git package
sudo apt-get install git -y

# Install ppp package
sudo apt-get install ppp -y

# Install pip package
sudo apt install python3-pip -y

# Install picamera package
# sudo pip install picamera

# Install RPi.GPIO
sudo apt-get install python3-rpi.gpio -y

# Add additional configuration lines to /boot/config.txt
{
  echo "dtoverlay=disable-bt"
  echo "init_uart_clock=64000000"
} | sudo tee -a /boot/config.txt

# Add baud rate configuration for I2C
sudo sed -i '/^dtparam=i2c_arm=on$/a dtparam=i2c_arm_baudrate=10000' /boot/config.txt

# Add pppd configuration lines to /etc/rc.local
sudo sed -i '/^exit 0$/i echo "Starting pppd..."\nstty -F /dev/ttyAMA0 raw\npppd /dev/ttyAMA0 1000000 10.0.5.1:10.0.5.2 proxyarp local noauth debug nodetach dump nocrtscts passive persist maxfail 0 holdoff 1' /etc/rc.local

# Create Restore folder
mkdir /home/pi/Restore

# Clone repository into Restore folder
git clone https://github.com/CoCl-Jerry/Max_Core_RELEASE.git /home/pi/Restore/Max_Core_RELEASE

# Make a copy of the cloned repository
cp -r /home/pi/Restore/Max_Core_RELEASE /home/pi

#reboot
sudo reboot

# End of the script
# Update raspi-config
# disable login shell and enable serial port
# add "@reboot sleep 15 && sudo sh /home/pi/Restore/Max_Core_RELEASE/startup.sh" to crontab -e