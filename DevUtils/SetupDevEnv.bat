@ECHO OFF
set THIS_PATH=%~0
set THIS_FOLDER=%~dp0

for %%I in ("%THIS_FOLDER%..\..\..\tools\Python\python.exe") do set "SRC_PYTHON=%%~fI"
for %%I in ("%THIS_FOLDER%..\..\..\tools\bmcpptPyVenv") do set "VENV_PATH=%%~fI"

IF [%1] EQU [] (
  echo Source Python not provided
  call :usage
  echo Using: %SRC_PYTHON%
  pause
) else (
  set SRC_PYTHON=%1
)

IF NOT EXIST "%SRC_PYTHON%" (
  echo Source Python executable not found: %SRC_PYTHON%
  call :usage
  pause
  exit /b 1
)

echo Using Python executable: %SRC_PYTHON%
echo Creating Python virtual environment in: %VENV_PATH%
%SRC_PYTHON% -m venv %VENV_PATH%

SET PATH=^
%VENV_PATH%\Scripts\;^
%PATH%
  :: Existing %PATH% at the end because it might contain %userprofile%\AppData\Local\Microsoft\WindowsApps with some executable shortcuts to the app store, e.g. python.exe

echo Installing Python requirements
pip install -r %THIS_FOLDER%PythonRequirements.txt

echo Running setup actions
penvstp ^
--dry-mode=default ^
--temp-folder=%THIS_FOLDER%..\..\..\temp ^
--tools-folder=%THIS_FOLDER%..\..\..\tools ^
--externals-folder=%THIS_FOLDER%..\..\..\externals ^
%THIS_FOLDER%env_setup_actions.json

goto end

:usage
echo ^> Usage: %THIS_PATH% [SOURCE_PYTHON]
echo ^> Example: %THIS_PATH% python.exe
goto :eof

:end

cmd /k

