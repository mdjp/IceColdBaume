#!/bin/bash
sleep 5
touch /tmp/lightswitch.dat
echo "0" > /tmp/lightswitch.dat
cd /home/icb/IceColdBaume/Python
sudo python3 keymapping.py &
cd /home/icb/IceColdBaume/Game
./ICB.x86 &
