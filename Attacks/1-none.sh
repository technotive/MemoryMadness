#!/bin/bash
# Ensure you have a version of NetCat (e.g. NCat) installed

echo ""
echo "Sending dog:3"
echo "dog:3" | nc -nv 127.0.0.1 9001
echo ""
echo "Sending hello:5"
printf "\x1b[34m"
echo "hello:5" | nc -nv 127.0.0.1 9001
printf "\x1b[0m"