#!/bin/bash
# Ensure you have a version of NetCat (e.g. NCat) installed

echo ""
echo $'Sending nullbyte'
echo $'\0' | nc -nv 127.0.0.1 9001