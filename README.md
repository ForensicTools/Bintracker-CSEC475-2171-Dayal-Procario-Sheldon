# Bintracker-CSEC475-2171-Dayal-Procario-Sheldon

Authors: Kortni Sheldon, Pranat Dayal, Christopher Procario

This tool scans binaries and executables for beacons/backdoors. It uses Bro to extract compiled binaries over network traffic and runs them in a cuckoo sandbox to identify backdoors.

INSTALLATION 
------------
Make sure you run the script as sudo. 

    sudo apt-get update
    
   
    cd setup
    sudo ./config.sh
    
    
    
This will install bro and cuckoo with all dependencies


POSSIBLE ERRORS/FIXES
---------------------

1) sudo apt-get update : make sure to update apt before installing
2) "unable to locate package CMake" :  change line 12 'CMake' to 'cmake' (lowercase)
3) "./cuckoo.sh: No such file or directory" : cd into setup directory and manually run "sudo ./cuckoo.sh" 

