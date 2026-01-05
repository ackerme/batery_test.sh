#!/bin/bash

echo "=== Top 10 processes by CPU usage ==="
ps aux --sort=-%cpu | head -11

echo ""
echo "=== Battery status ==="
upower -i /org/freedesktop/UPower/devices/battery_BAT0

echo ""
echo "=== Power consumption ==="
cat /sys/class/power_supply/BAT0/power_now 2>/dev/null || echo "Power info not available"
