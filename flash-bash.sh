#!/usr/bin/env bash

clear

lsblk

printf "\n\n\n"
echo -e "\033[31mUSING THIS TOOL CAN BE DESTRUCTIVE! USE AT YOUR OWN PRECAUTIONS\033[0m"

printf "\n\n\n"
echo "Enter device to write to: "
read device

printf "\n\n"
echo "Enter image to write from: "
read image

printf "\n\n\n\n"

sudo dd if=$image of=$device bs=1M status=progress
