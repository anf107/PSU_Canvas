This Vagrant VM is based off the quick start instructions in the Canvas Github repo.  If you have problems building the VM you should first try to use a different stable branch of Canvas code in the .sh file.  We've had a few stable canvas releases that were not so stable.

Requirements...

Install 
   vagrant from http://www.vagrantup.com/downloads
   SSH client - the one provided with git works well  - http://git-scm.com/download/win
   After these installs reboot

Start site with up.bat.  It may take a few minutes to start the bb services.  Rebuild vm with destroy.bat and then up.bat  You can modify the vagrantfile with different options.  A nice one is to uncomment the vb.gui line.  That will show a terminal window for the vm.  

URL for site is http://10.0.10.10:3000