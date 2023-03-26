#!/bin/bash
# Ensure you have a version of NetCat (e.g. NCat) installed

echo ""
echo $'Sending \0dog:4'
echo $'\0dog:4' | nc -nv 127.0.0.1 9001