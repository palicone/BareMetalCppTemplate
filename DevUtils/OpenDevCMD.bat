@ECHO OFF
set THIS_FOLDER=%~dp0

for %%I in ("%THIS_FOLDER%..\..\..\tools\bmcpptPyVenv") do set "VENV_PATH=%%~fI"

SET PATH=^
%VENV_PATH%\Scripts\;^
%PATH%
  :: Existing %PATH% at the end because it might contain %userprofile%\AppData\Local\Microsoft\WindowsApps with some executable shortcuts to the app store, e.g. python.exe

CD %THIS_FOLDER%\..\

cmd /k
