#!/usr/bin/env bash
# Shortcut: ./build.sh <command> [arguments] is sitetool <command> (./build.sh help lists them).
cd "$(dirname "$0")" && mkdir -p build && exec odin run tools/sitetool -collection:gt=ext/gui_toolkit/src -out:build/sitetool -keep-executable -- "$@"
