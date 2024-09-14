#!/usr/bin/env bash

RED='\033[31m'
CYAN='\033[36m'
NORMAL='\033[0m'

if [ $# -eq 0 ]; then
    echo -e "${RED}Error: No font file provided.${NORMAL}"
    echo "Usage: $0 font-file [font-file2 ...]"
    exit 1
fi

for font in "$@"; do
    if [ -f "$font" ]; then
        echo -e "${CYAN}Installing font: $font${NORMAL}"
        sudo cp "$font" /usr/share/fonts/
    else
        echo -e "${RED}Error: Font file '$font' not found.${NORMAL}"
    fi
done

echo -e "${CYAN}Rebuilding font cache...${NORMAL}"
sudo fc-cache -f -v

printf '\n%.0s' {1..5}

echo -e "${CYAN}Installed fonts:${NORMAL}"
for font in "$@"; do
    font_name=$(basename "$font" | sed 's/\.[^.]*$//')
    fc-list | grep -i "$font_name"
done

