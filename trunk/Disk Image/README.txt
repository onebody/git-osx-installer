Git OSX Installer

http://code.google.com/p/git-osx-installer/

----------------------------------
Step 1 - Install Package
----------------------------------
This installs git to /usr/local/git.  Root access is required.

----------------------------------
Step 2 - Run shell script
----------------------------------
Since /usr/local/git/bin and /usr/local/git/man aren't in your PATH variables by default, it will make git a bit difficult to use.

Run the provided shell script to update your ~/.bash_profile and ~/.MacOSX/environment.plist file to include these paths.