#!/bin/bash
sleep 5
cd /
cd home/icb/ICB/virtkeys
sudo python3 keymapping.py &
cd ..
./ICB.x86_64 &
cd /
