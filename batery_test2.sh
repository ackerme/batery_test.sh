#!/bin/bash

# צבעים
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

clear
echo -e "${GREEN}╔════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║    Battery Power Monitor - Ubuntu     ║${NC}"
echo -e "${GREEN}╔════════════════════════════════════════╗${NC}"
echo ""

# מידע על הסוללה
echo -e "${BLUE}=== Battery Information ===${NC}"
battery_path="/sys/class/power_supply/BAT0"

if [ -d "$battery_path" ]; then
    status=$(cat $battery_path/status 2>/dev/null)
    capacity=$(cat $battery_path/capacity 2>/dev/null)
    
    echo "Status: $status"
    echo "Capacity: $capacity%"
    
    # חישוב צריכת חשמל נוכחית
    if [ -f "$battery_path/power_now" ]; then
        power_now=$(cat $battery_path/power_now)
        power_watts=$(echo "scale=2; $power_now / 1000000" | bc)
        echo "Current Power Draw: ${power_watts}W"
    fi
else
    echo "Battery information not available"
fi

echo ""
echo -e "${BLUE}=== Top 10 CPU Consumers ===${NC}"
printf "%-30s %8s %8s\n" "PROCESS" "CPU%" "MEM%"
echo "────────────────────────────────────────────────"
ps aux --sort=-%cpu | awk 'NR>1 && NR<=11 {printf "%-30s %7.1f%% %7.1f%%\n", substr($11,1,30), $3, $4}'

echo ""
echo -e "${BLUE}=== Background Services ===${NC}"
systemctl list-units --type=service --state=running --no-pager | head -8

echo ""
echo -e "${YELLOW}Press Ctrl+C to exit${NC}"
echo ""

# לולאה להצגה מתמשכת (אופציונלי)
# while true; do
#     sleep 5
#     clear
#     # כאן אפשר לחזור על הקוד למעלה
# done
