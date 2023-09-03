#!/bin/bash

# Update and upgrade the Raspberry Pi
sudo apt-get update
sudo apt-get upgrade -y

# Add avoid_warnings configuration
echo "avoid_warnings=1" | sudo tee -a /boot/config.txt

# Remove lxplug-ptbatt package
sudo apt-get remove -y lxplug-ptbatt

# Install ppp package
sudo apt-get install -y ppp

# Install libatlas-base-dev package
sudo apt-get install -y libatlas-base-dev

# Add additional configuration lines to /boot/config.txt
{
  echo "dtoverlay=disable-bt"
  echo "init_uart_clock=64000000"
  #echo "hdmi_cvt=1024 600 60 3 0 0 1"
  #echo "hdmi_group=2"
  #echo "hdmi_mode=87"
} | sudo tee -a /boot/config.txt

# Add baud rate configuration for I2C
sudo sed -i '/^dtparam=i2c_arm=on$/a dtparam=i2c_arm_baudrate=10000' /boot/config.txt

# Add pppd configuration lines to /etc/rc.local
sudo sed -i '/^exit 0$/i echo "Starting pppd..."\nstty -F /dev/ttyAMA0 raw\nstty -F /dev/ttyAMA0 -a\npppd /dev/ttyAMA0 1000000 10.0.5.2:10.0.5.1 noauth local debug dump  nocrtscts persist maxfail 0 holdoff 1' /etc/rc.local

# Upgrade setuptools
sudo pip3 install --upgrade setuptools

# Install 
# sudo pip3 install adafruit-circuitpython-mma8451

# Change directory to home
cd ~

# Upgrade adafruit-python-shell
sudo pip3 install --upgrade adafruit-python-shell

# Download raspi-blinka.py script
wget https://raw.githubusercontent.com/adafruit/Raspberry-Pi-Installer-Scripts/master/raspi-blinka.py

# Run raspi-blinka.py
yes n | sudo python3 raspi-blinka.py

# Install adafruit-circuitpython-bme280
sudo pip3 install adafruit-circuitpython-bme280

# Install adafruit-circuitpython-lsm6ds
sudo pip3 install adafruit-circuitpython-lsm6ds

# Install pyqtgraph
sudo pip3 install pyqtgraph

# Clone Clinostat Control Center
cd ~
mkdir ~/Documents/Restore
cd ~/Documents/Restore
git clone -b FL32899KS https://github.com/CoCl-Jerry/SciSpin_Max_RELEASE.git
sh ~/Documents/Restore/SciSpin_Max_RELEASE/update.sh
cp ~/Documents/Restore/SciSpin_Max_RELEASE/run.desktop ~/Desktop
cp ~/Documents/Restore/SciSpin_Max_RELEASE/update.desktop ~/Desktop

# End of the script
# in config disable SSH Serial Console
# Change background and text color
