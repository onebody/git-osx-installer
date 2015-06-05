Open In Git GUI Troubleshooting

# It doesn't launch #

There's a variety of reasons it might not be launching. Try launching it from the command line by typing 'git gui' - do you see an error message.

If you get something like this:

```
dyld: Library not loaded: /Library/Frameworks/Tk.framework/Versions/8.5/Tk
  Referenced from: /usr/local/git/share/git-gui/lib/Git
Gui.app/Contents/MacOS/Wish
  Reason: image not found
fatal: unable to run 'git-gui'
```

You'll need to install [Tcl / TK Aqua](http://www.categorifiedcoder.info/tcltk/)