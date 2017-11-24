# Bintracker

Authors: Kortni Sheldon, Pranat Dayal, Christopher Procario
-------

Extracts files over a network to check for malicious executables/backdoors. 

INSTALLATION 
------------
Make sure you run the script as sudo. 

    sudo apt-get update
    sudo ./config.sh 
    
    
This will install bro with all dependencies.(This may take a while)

Virustotal: your API-KEY is requried to perform virustotal checks.

POSSIBLE ERRORS/FIXES
---------------------

1) sudo apt-get update : make sure to update apt before installing
2) "unable to locate package CMake" :  change line 12 'CMake' to 'cmake'


USAGE
-----

    python bintracker.py

You will be greeted with a command shell. 


