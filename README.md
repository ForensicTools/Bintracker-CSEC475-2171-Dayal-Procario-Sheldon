# Bintracker

Authors: Kortni Sheldon, Pranat Dayal, Christopher Procario
-------

Extracts files over a network to check for malicious executables/backdoors. 

INSTALLATION 
------------
Make sure you run the script as sudo. 

    sudo apt-get update
    
   
    cd setup
    sudo ./config.sh
    
    
    
This will install bro and cuckoo with all dependencies

While installing cukoo it will add a new user on the box. It will ask for a password and information 
about the user. 


POSSIBLE ERRORS/FIXES
---------------------

1) sudo apt-get update : make sure to update apt before installing
2) "unable to locate package CMake" :  change line 12 'CMake' to 'cmake' (lowercase)
3) "./cuckoo.sh: No such file or directory" : cd into setup directory and manually run "sudo ./cuckoo.sh" 

