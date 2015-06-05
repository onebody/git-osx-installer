A droplet which allows you to open Git-Gui from finder.

![http://git-osx-installer.googlecode.com/files/OpenInGitGui-2.0.png](http://git-osx-installer.googlecode.com/files/OpenInGitGui-2.0.png)

To install, http://code.google.com/p/git-osx-installer/downloads/list?q=label:Featured, and extract to /Applications/Scripts (you'll need to create the Scripts directory, likely).  Then, find the icon, and drag it up to your toolbar.  Keep it there for a few seconds until it "sticks".

To use, open finder to a folder with a git repository, and click the "Git" icon.

# CHANGES #

Version 2.1

  * Fixes bug where repository paths with spaces could not be opened.

Version 2.0

  * No longer require an open terminal to get ssh fetches to work. (uses an invisible daemonized screen session instead).
  * 2 git-gui instances would be launched by the droplet. That has been addressed and should only happen on extremely rare occasions. (update - actually... it happens every time git gui takes longer than 0.25 seconds to launch, which is the case if git-gui and supporting libraries haven't been cached to disk.  bummer)
  * Now sports an AWESOME icon (thanks Jake Smith)

# Credits #

This is really a modified version of [open in textmate](http://henrik.nyh.se/2007/10/open-in-textmate-from-leopard-finder),