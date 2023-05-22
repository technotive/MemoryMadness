#!/bin/bash
# Ensure you have a version of NetCat (e.g. NCat) installed

echo ""
echo "Sending dog:0"
echo "dog:0" | nc -nv 127.0.0.1 9001
echo ""
echo "Sending hello:4"
printf "\x1b[34m"
echo "hello:4" | nc -nv 127.0.0.1 9001
printf "\x1b[0m"