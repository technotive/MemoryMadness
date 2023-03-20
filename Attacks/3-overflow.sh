#!/bin/bash
# Ensure you have a version of NetCat (e.g. NCat) installed

echo ""
echo "Sending dog:4"
echo "dog:4" | nc -nv 127.0.0.1 9001
echo ""
echo "Sending hello:11"
echo "hello:11" | nc -nv 127.0.0.1 9001