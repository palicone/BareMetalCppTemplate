@echo off
set pico_sdk_dest=%~dp0..\externals\pico-sdk
if exist %pico_sdk_dest% (
echo %pico_sdk_dest% already exists!
echo IT WILL BE DELETED
echo Ctrl+C to abort
pause
rmdir /s /q %pico_sdk_dest%
)
git clone https://github.com/raspberrypi/pico-sdk.git %pico_sdk_dest%
git -C %pico_sdk_dest% submodule update --init