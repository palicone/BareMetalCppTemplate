@ECHO OFF
set THIS_PATH=%~0
set THIS_FOLDER=%~dp0

for %%I in ("%THIS_FOLDER%..\..\..\tools\Python\python.exe") do set "SRC_PYTHON=%%~fI"
for %%I in ("%THIS_FOLDER%..\..\..\tools\bmcpptPyVenv") do set "VENV_PATH=%%~fI"

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

cmd /k

