#!/bin/bash

echo "Uninstalling ALCPlugFix. Root user is required."

# check if the root filesystem is writeable (starting with macOS 10.15 Catalina, the root filesystem is read-only by default)
if sudo test ! -w "/"; then
  sh Enable_copy_file.sh
fi

sudo rm /usr/local/bin/ALCPlugFix
sudo rm /usr/local/bin/hda-verb
sudo launchctl unload -w /Library/LaunchDaemons/good.win.ALCPlugFix.plist
sudo launchctl remove good.win.ALCPlugFix
sudo rm /Library/LaunchDaemons/good.win.ALCPlugFix.plist

echo "Done!"
exit 0
