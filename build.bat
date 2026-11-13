@echo off
rem Shortcut: build.bat <command> [arguments] is sitetool <command> (build.bat help lists them).
cd /d "%~dp0"
if not exist build mkdir build
odin run tools/sitetool -collection:gt=ext/gui_toolkit/src -out:build/sitetool -keep-executable -- %*
