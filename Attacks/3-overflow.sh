#!/bin/bash
# Ensure you have a version of NetCat (e.g. NCat) installed

echo ""
echo "Sending dog:10"
echo "dog:10" | nc -nv 127.0.0.1 9001
echo ""
echo "Sending hello:100"
printf "\x1b[34m"
echo "hello:100" | nc -nv 127.0.0.1 9001
printf "\x1b[0m"