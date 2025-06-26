#!/bin/bash

format_time() {
    local total_seconds=$1
    printf "%02d:%02d:%02d" $((total_seconds/3600)) $(((total_seconds%3600)/60)) $((total_seconds%60))
}

# Colors
if command -v tput >/dev/null 2>&1; then
    BOLD=$(tput bold)
    GREEN=$(tput setaf 2)
    YELLOW=$(tput setaf 3)
    BLUE=$(tput setaf 4)
    RESET=$(tput sgr0)
else
    BOLD="" GREEN="" YELLOW="" BLUE="" RESET=""
fi

echo "${GREEN}${BOLD}Timer started...${RESET} (Press Enter to stop)"

start_time=$(date +%s)

while true; do
    elapsed=$(($(date +%s) - start_time))
    printf "\r${YELLOW}${BOLD}Elapsed: %s${RESET}" "$(format_time $elapsed)"
    
    # Check if Enter was pressed (with 1 second timeout)
    if read -r -t 1; then
        break
    fi
done

echo
echo "${BLUE}${BOLD}Timer stopped at: $(format_time "$elapsed")${RESET}"
