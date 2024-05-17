modified version of the linux x86 install script

the original version had an embedded .tar.gz file in the install script
in plain binary data, which made file handling very brittle. this modified
version contains the same binary data, but base64 encoded.
