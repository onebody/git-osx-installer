Git OSX Installer

http://code.google.com/p/git-osx-installer/

----------------------------------
Step 1 - Install Package
----------------------------------
This installs git to /usr/local/git.  Root access is required.

----------------------------------
Step 2 - Run shell script
----------------------------------
This step is optional.

Non-terminal programs don't inherit the system wide PATH and MANPATH variables that your terminal does.  If you'd like them to be able to see Git, for whatever reason, you can run this script.  It will add the PATH and MANPATH to your ~/.MacOSX/environment.plist file.  You'll need to log out of your user account for that to take effect.