# BareMetalCppTemplate
Minimal C++ (deep) embedded project template with GCC and CMake

# Setup
## Prerequisites
- CMake
- Pyhton
- ninja-build
- Native build tools (for RPiPico projects)

## Procedure
1. Prepare the development folder
   >   This serves as a top level development folder.
   You probably already have it.
   It will hold temp, tools etc. subfolders. 

   Examples:
   ~~~
   C:\Projects
   ~~~
   ~~~
   ~/dev
   ~~~

2. Prepare subfolder for this project.

   >   This will __not__ be the checkout folder.
   Checkout will be one folder deeper so that the checkout depth is the same regardless if the repo is used as main development folder or as a dependency in externals subfolder.
   _Ignore previous sentence_.

3. Checkout/clone the project in the prepared subfolder. It will create the actual repo folder.
   ~~~
   C:\Projects\bmcppt>git clone https://github.com/palicone/BareMetalCppTemplate.git
   ~~~
   
4. Run environment setup script.
   Give it a path to (preferably clean) Python executable.
   ~~~
   C:\Projects\bmcppt>BareMetalCppTemplate\DevUtils\SetupDevEnv.bat python.exe
   ~~~
   
Final folder should like something like:
~~~
C:
|-Projects
  |-bmcppt
  | |+BareMetalCppTemplate
  |+externals
  | |+pico-sdk
  |+temp
  |-tools
    |+bmcpptPyVenv
    ...  
~~~

# Build
~~~
C:\Projects\bmcppt>cmake --preset ARMv7M-fromWin-release -S BareMetalCppTemplate
C:\Projects\bmcppt>cmake --build BareMetalCppTemplate-bin-ARMv7M-fromWin-release --target Template
~~~

RPiPico projects must be built from the environment aware of the native build tools.
> RPiPico binaries are generated with the 'picotool' which is built from sources in pico-sdk.

To get in the CMD, open Visual Studio **'Developer Command Prompt for VS'** from the Start menu.
~~~
C:\Projects\bmcppt>cmake --preset RPiPico-fromWin-debug -S BareMetalCppTemplate
C:\Projects\bmcppt>cmake --build BareMetalCppTemplate-bin-RPiPico-fromWin-debug --target hollow_pi
~~~
