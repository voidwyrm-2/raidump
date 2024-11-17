#! /bin/sh

zig build-exe --name raidump main.zig
if [ -f "raidump.o" ]; then
    rm -rf raidump.o
fi

if [ "$1" = "-i" ] && [ "$2" != "" ] && [ -f "raidump" ]; then
    mv ./raidump "$2/raidump"
fi
