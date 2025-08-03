# BareMetalCppTemplate
Minimal C++ (deep) embedded project template with GCC and CMake

# Setup
## Prerequisites
- CMake 3.16 or higher
- Pyhton 3.6 or higher
- ninja-build

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

3. Checkout/clone the project in the prepared subfolder
   ~~~
   C:\Projects\bmcppt>git clone https://github.com/palicone/BareMetalCppTemplate.git
   ~~~