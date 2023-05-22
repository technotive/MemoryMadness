#!/bin/bash
# Ensure you have a version of NetCat (e.g. NCat) installed

echo ""
echo $'Sending nullbyte'
printf "\x1b[34m"
echo $'\0' | nc -nv 127.0.0.1 9001
printf "\x1b[0m"