#! /bin/sh

NAME="raidump"

zig build-exe --name "$NAME" main.zig
if [ -f "$NAME.o" ]; then
    rm -rf "$NAME.o"
fi

if [ "$1" = "-i" ] && [ "$2" != "" ] && [ -f "$NAME" ]; then
    mv "./$NAME" "$2/$NAME"
fi
