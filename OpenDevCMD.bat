@echo off

set THIS_FOLDER=%~dp0

SET PATH=%THIS_FOLDER%..\Tools\cmake-3.30.0-rc3-windows-x86_64\bin\;^
%THIS_FOLDER%..\Tools\;^
%PATH%

CD %THIS_FOLDER%

cmd /k