the files in this directory are used to install the sdk, which mainly
contains some shared libraries for low-level communication with the cameras.

the script file 'generate_base64_install_script.sh' is used to modify the
original install scripts for improved file handling.
(the original install scripts embed a .tar.gz file in plain binary. this
script generates a new script file from those that has the same data
embedded, as base64 encoded data)
