#!/bin/bash
# Ensure you have a version of NetCat (e.g. NCat) installed

echo ""
echo $'Sending some chinese text'
echo $'请给我六个字:6' | nc -nv 127.0.0.1 9001