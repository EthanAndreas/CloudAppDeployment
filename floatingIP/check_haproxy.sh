#!/bin/sh
pgrep haproxy
if [ $? -eq 0 ]; then
    exit 0
else
    exit 1
fi