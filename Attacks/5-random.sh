#!/bin/bash
# Ensure you have a version of NetCat (e.g. NCat) installed

echo ""
echo $'Sending random data'
printf "\x1b[34m"
echo $'\1\3\4\5\7\1\0' | nc -nv 127.0.0.1 9001
printf "\x1b[0m"