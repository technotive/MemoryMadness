#!/bin/bash
# Ensure you have a version of NetCat (e.g. NCat) installed

echo ""
echo $'Sending some chinese text'
printf "\x1b[34m"
echo $'请给我六个字:6' | nc -nv 127.0.0.1 9001
printf "\x1b[0m"